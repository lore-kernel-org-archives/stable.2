Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5644B309DDB;
	Fri, 17 Jul 2026 12:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291840; cv=none; b=LqtmbQLFXbBN6Y1gkpmnFPyMThxzOAMGKCAmHOXEs6k3/HsHGkCqMrzi/1xxHevIMMHK6rwTgEavWZxNpMZMuIwS7BOtTKy/HYOwMZJpqTN8EMTwHKHLPNKbIi94sA6TWFmkutM/20IvPaBUPR+mYfS7sjSX41OS6Avphmqwakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291840; c=relaxed/simple;
	bh=7yut5cpCju07AY1s/WSgZ6BNVqcQfe4iJL1O2nZr9zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNdwenuy9/k3U18pYz6sDp2mtsao1MLkcTMqxTTmGFzUKb4S8gjMmispCZvwtc6QyILFGjjyM6Ht/tG7ax/JH6HlcpOVAyuWq6ie9lupX7/oGnp9xXXRsMKyh7ETasJhnZ0n8ORRLj72GyNGBqnC6SECD0hoylZtbhSENpacTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nZLkE/bJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nZLkE/bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C1E1F000E9;
	Fri, 17 Jul 2026 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784291836;
	bh=10Pps67StB+D8Oz+CHxSoKLyp+1YN5wm9G/z2f5JrXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZLkE/bJSWWf4AiQe5eLUgmhe0knks4wC+kwBdmZE11uvU+0fujSa8aLvBxLzJJP0
	 mXrP+NCZhlFZRE3SZ0HvYREIONpfot14m46IQe2McS/52sSyKNcbHh0jg1e3wylSPI
	 h/sf1qVavLL8OGLMDuu24XZqF2V1M/0b0kSfZxqg=
Date: Fri, 17 Jul 2026 14:37:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: w15303746062@163.com
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, kees@kernel.org,
	stable@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: Re: [PATCH v4 2/2] misc: ibmasm: Fix dynamic out-of-bounds MMIO
 access via malicious MFA
Message-ID: <2026071745-bamboo-aerobics-7657@gregkh>
References: <20260624032425.384325-1-w15303746062@163.com>
 <20260624032425.384325-3-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624032425.384325-3-w15303746062@163.com>

On Wed, Jun 24, 2026 at 11:24:25AM +0800, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> The ibmasm driver reads dynamic Message Frame Addresses (MFA) from
> hardware queues and uses them directly as offsets to dereference I2O
> messages via get_i2o_message().
> 
> If a malformed or fuzzed device provides a malicious MFA, it can cause
> the driver to access memory far beyond the mapped BAR, leading to an
> out-of-bounds (OOB) access and potential kernel panic during runtime.
> 
> Fix this by validating the target offset against the actual mapped size
> before dereferencing. This validation strictly accounts for both the
> i2o_header and the dynamic payload size using safe subtraction to prevent
> integer overflow bypasses.
> 
> If the bounds check fails, the invalid MFA is released back to the
> inbound queue via set_mfa_inbound() to prevent a hardware mailbox deadlock.
> 
> Fixes: bdbeed75b288 ("pci: use pci_ioremap_bar() in drivers/misc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>  drivers/misc/ibmasm/lowlevel.c | 30 ++++++++++++++++++++++++++----
>  drivers/misc/ibmasm/lowlevel.h | 25 +++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/ibmasm/lowlevel.c b/drivers/misc/ibmasm/lowlevel.c
> index 5313230f36ad..68dd493a7953 100644
> --- a/drivers/misc/ibmasm/lowlevel.c
> +++ b/drivers/misc/ibmasm/lowlevel.c
> @@ -9,7 +9,6 @@
>  
>  #include "ibmasm.h"
>  #include "lowlevel.h"
> -#include "i2o.h"
>  #include "dot_command.h"
>  #include "remote.h"
>  
> @@ -34,7 +33,13 @@ int ibmasm_send_i2o_message(struct service_processor *sp)
>  		return 1;
>  
>  	header.message_size = outgoing_message_size((unsigned int)command_size);
> -	message = get_i2o_message(sp->base_address, mfa);
> +	message = get_i2o_message(sp->base_address, sp->mapped_size, mfa,
> +				  sizeof(struct i2o_header) + command_size);
> +	if (!message) {
> +		/* Release the allocated inbound MFA to prevent mailbox deadlock */
> +		set_mfa_inbound(sp->base_address, mfa);
> +		return 1;
> +	}
>  
>  	memcpy_toio(&message->header, &header, sizeof(struct i2o_header));
>  	memcpy_toio(&message->data, command->buffer, command_size);
> @@ -63,8 +68,25 @@ irqreturn_t ibmasm_interrupt_handler(int irq, void * dev_id)
>  
>  	mfa = get_mfa_outbound(base_address);
>  	if (valid_mfa(mfa)) {
> -		struct i2o_message *msg = get_i2o_message(base_address, mfa);
> -		ibmasm_receive_message(sp, &msg->data, incoming_data_size(msg));
> +		struct i2o_message *msg = get_i2o_message(base_address,
> +							  sp->mapped_size, mfa,
> +							  sizeof(struct i2o_header));
> +		if (msg) {
> +			u32 data_size = incoming_data_size(msg);
> +			u32 offset = GET_MFA_ADDR(mfa);
> +
> +			/*
> +			 * Secondary check for dynamic payload size.
> +			 * Use subtraction to perfectly prevent integer overflow.
> +			 */
> +			if (unlikely(data_size > sp->mapped_size - offset -
> +						 sizeof(struct i2o_header)))
> +				dbg("received mfa payload out of bounds\n");
> +			else
> +				ibmasm_receive_message(sp, &msg->data, data_size);
> +		} else {
> +			dbg("received mfa header out of bounds\n");
> +		}
>  	} else
>  		dbg("didn't get a valid MFA\n");
>  
> diff --git a/drivers/misc/ibmasm/lowlevel.h b/drivers/misc/ibmasm/lowlevel.h
> index 545dfe384117..c0f08106c52c 100644
> --- a/drivers/misc/ibmasm/lowlevel.h
> +++ b/drivers/misc/ibmasm/lowlevel.h
> @@ -13,6 +13,9 @@
>  #define __IBMASM_CONDOR_H__
>  
>  #include <asm/io.h>
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include "i2o.h"
>  
>  #define VENDORID_IBM	0x1014
>  #define DEVICEID_RSA	0x010F
> @@ -118,9 +121,27 @@ static inline void set_mfa_inbound(void __iomem *base_address, u32 mfa)
>  	writel(mfa, base_address + INBOUND_QUEUE_PORT);
>  }
>  
> -static inline struct i2o_message *get_i2o_message(void __iomem *base_address, u32 mfa)
> +/**
> + * get_i2o_message - Convert MFA to i2o_message pointer with bounds check
> + * @base_address: BAR 0 virtual address
> + * @mapped_size:  actual size of BAR 0 mapping
> + * @mfa:          Message Frame Address from hardware
> + * @msg_size:     Required size of the message (header + payload)
> + *
> + * Returns NULL if the offset derived from @mfa does not fit within
> + * the mapped BAR (including the i2o_message header).
> + */
> +static inline struct i2o_message *get_i2o_message(void __iomem *base_address,
> +						  resource_size_t mapped_size,
> +						  u32 mfa, size_t msg_size)
>  {
> -	return (struct i2o_message *)(GET_MFA_ADDR(mfa) + base_address);
> +	u32 offset = GET_MFA_ADDR(mfa);
> +
> +	/* Prevent read/write beyond the ioremap region and avoid integer underflow/overflow */
> +	if (unlikely(offset > mapped_size || msg_size > mapped_size - offset))
> +		return NULL;
> +
> +	return (struct i2o_message *)(offset + base_address);
>  }

That is a big function to inline, are you sure it's still needed that
way and shouldn't just go in the .c file?

thanks,

greg k-h
