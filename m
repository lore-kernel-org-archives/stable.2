Received: from out-167.mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A723E00A9
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851757; cv=none; b=gOJ7IO04NZZ16/d/hfAGsFy3HciG2APS2xMZGCe6r87V3AncZCyjSZcaH0g4VqDC6OBlmr+Px2DcCsEqTl2VLRG4G4Fimrbz9CH1G2pyQBCzYTRMNysZPrNoDwoPPmVlCkpJA1OsuR0cNYCI14ZNCUa1U0PnP34YxkhNEU+GSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851757; c=relaxed/simple;
	bh=LcYiPqB4tVrRiy7Cltegl8juqIwND8gItntjWapowOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6gnK8I3Zwumf7L3jcXyw9AXGVVhHIEqu/IItvioW7KnzR5OabKqfxWJwuZLhn1pe0BwlJ3o8fjFCuL9gafrpkomBZAK1UcrpeZqk7fquTde8FF6TY5kE5fnB3sV40fop97DdrUm01pkpvy5HyWWkWqvlzOcolN9ulg2i+HD2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYZtil51; arc=none smtp.client-ip=95.215.58.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FYZtil51"
Message-ID: <4ef01fa0-969f-4ec0-997b-5f5f3f67e11a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785851742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYaRYJJ4lK/MLOWAM2e1uCFUmqoZIVPfPNaQ31GMp0Q=;
	b=FYZtil51LzrZNx/hTwezUS2eYSm/487ebVTBuTingdSO8uBcyrhjubzK1fAG6PcwWSkRPD
	zBrz32hja2gVCBTzht+8r03mrRntjCdIpIvmrBDfj3qKue+wASayNRuJEd3iYBE708hwp2
	46ODWFVYxV9tghywi/XhsIpsaAGZbZM=
Date: Tue, 4 Aug 2026 14:55:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC net-next v2 4/6] ptp: ocp: Validate EEPROM board IDs
To: Ahmad Byagowi <ahmadexp@gmail.com>, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Peter Rosin <peda@lysator.liu.se>, Nam Tran <trannamatk@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260803205011.1249-1-ahmadexp@gmail.com>
 <20260803205011.1249-5-ahmadexp@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260803205011.1249-5-ahmadexp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/08/2026 21:50, Ahmad Byagowi wrote:
> The EEPROM board ID is a fixed 13-byte field. It is stored without room
> for a terminator and passed to devlink as a C string. An erased EEPROM
> therefore exposes 0xff bytes and can make devlink read beyond the field
> while formatting board.id.
> 
> Reserve a trailing byte, classify erased and malformed contents, and
> publish board.id only when the field contains printable text with valid
> padding. Continue reporting the serial number when the board ID is
> absent.
> 
> Fixes: 0cfcdd1ebcfe1a9b262f6ad8419580720dc843c4 ("ptp: ocp: add nvmem interface for accessing eeprom")

use short format of hash to provide commit to fix:

Fixes: 0cfcdd1ebcfe ("ptp: ocp: add nvmem interface for accessing eeprom")

And as this is a fix, it has to go to net rather than net-next

> Cc: stable@vger.kernel.org
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> ---
>   drivers/ptp/ptp_ocp.c | 69 +++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 66 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1a..cec936bd1 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -347,6 +347,13 @@ struct ptp_ocp_serial_port {
>   #define OCP_SIGNAL_NUM			4
>   #define OCP_FREQ_NUM			4
>   
> +enum ptp_ocp_board_id_state {
> +	OCP_BOARD_ID_UNREAD,
> +	OCP_BOARD_ID_VALID,
> +	OCP_BOARD_ID_ERASED,
> +	OCP_BOARD_ID_INVALID,
> +};
> +
>   enum {
>   	PORT_GNSS,
>   	PORT_GNSS2,
> @@ -401,8 +408,9 @@ struct ptp_ocp {
>   	bool			fw_loader;
>   	u8			fw_tag;
>   	u16			fw_version;
> -	u8			board_id[OCP_BOARD_ID_LEN];
> +	char			board_id[OCP_BOARD_ID_LEN + 1];
>   	u8			serial[OCP_SERIAL_LEN];
> +	enum ptp_ocp_board_id_state board_id_state;
>   	bool			has_eeprom_data;
>   	u32			pps_req_map;
>   	int			flash_start;
> @@ -472,18 +480,23 @@ struct ptp_ocp_eeprom_map {
>   	.len = sizeof_field(struct ptp_ocp, member),		\
>   	.bp_offset = offsetof(struct ptp_ocp, member)
>   
> +#define EEPROM_ENTRY_LEN(addr, member, entry_len)		\
> +	.off = addr,						\
> +	.len = entry_len,					\
> +	.bp_offset = offsetof(struct ptp_ocp, member)
> +
>   #define BP_MAP_ENTRY_ADDR(bp, map) ({				\
>   	(void *)((uintptr_t)(bp) + (map)->bp_offset);		\
>   })
>   
>   static struct ptp_ocp_eeprom_map fb_eeprom_map[] = {
> -	{ EEPROM_ENTRY(0x43, board_id) },
> +	{ EEPROM_ENTRY_LEN(0x43, board_id, OCP_BOARD_ID_LEN) },
>   	{ EEPROM_ENTRY(0x00, serial), .tag = "mac" },
>   	{ }
>   };
>   
>   static struct ptp_ocp_eeprom_map art_eeprom_map[] = {
> -	{ EEPROM_ENTRY(0x200 + 0x43, board_id) },
> +	{ EEPROM_ENTRY_LEN(0x200 + 0x43, board_id, OCP_BOARD_ID_LEN) },
>   	{ EEPROM_ENTRY(0x200 + 0x63, serial) },
>   	{ }
>   };
> @@ -1969,6 +1982,52 @@ ptp_ocp_nvmem_device_put(struct nvmem_device **nvmemp)
>   	*nvmemp = NULL;
>   }
>   
> +static enum ptp_ocp_board_id_state
> +ptp_ocp_classify_board_id(char *board_id)
> +{
> +	bool all_zero = true;
> +	bool all_ones = true;
> +	bool terminated = false;
> +	unsigned int i;
> +
> +	board_id[OCP_BOARD_ID_LEN] = '\0';
> +	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
> +		u8 value = board_id[i];
> +
> +		all_zero &= value == 0;
> +		all_ones &= value == 0xff;
> +	}
> +
> +	if (all_zero || all_ones) {
> +		board_id[0] = '\0';
> +		return OCP_BOARD_ID_ERASED;
> +	}
> +
> +	for (i = 0; i < OCP_BOARD_ID_LEN; i++) {
> +		u8 value = board_id[i];
> +
> +		if (terminated) {
> +			if (value)
> +				goto invalid;
> +			continue;
> +		}
> +
> +		if (!value) {
> +			terminated = true;
> +			continue;
> +		}
> +		if (value < 0x20 || value > 0x7e)
> +			goto invalid;
> +	}
> +
> +	if (board_id[0])
> +		return OCP_BOARD_ID_VALID;
> +
> +invalid:
> +	board_id[0] = '\0';
> +	return OCP_BOARD_ID_INVALID;
> +}
> +
>   static void
>   ptp_ocp_read_eeprom(struct ptp_ocp *bp)
>   {
> @@ -2001,6 +2060,7 @@ ptp_ocp_read_eeprom(struct ptp_ocp *bp)
>   			goto fail;
>   	}
>   
> +	bp->board_id_state = ptp_ocp_classify_board_id(bp->board_id);
>   	bp->has_eeprom_data = true;
>   
>   out:
> @@ -2177,6 +2237,9 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>   	if (err)
>   		return err;
>   
> +	if (bp->board_id_state != OCP_BOARD_ID_VALID)
> +		return 0;
> +

why don't simply
snprintf(buf, OCP_BOARD_ID_LEN + 1, "%s", bp->board_id); ?

buf is already used in the function, let's reuse it

>   	err = devlink_info_version_fixed_put(req,
>   			DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
>   			bp->board_id);

