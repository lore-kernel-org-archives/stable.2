Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581199;
	b=1fOh91V3nfP0P3LtQ6fe7t9CwMKykOuHFku8lcjDMOj9jfzDhQtRSqrSCiliHoRuc+dr
	 VWNk6L8VXjrkfAyOf+0WkH6NIAJgpTJM1Jr58fxTHZ9bdBe4RoupO0b76juPjyDt7Bcuj
	 nPdE9Q4WjeNuJQz53F6AcZhduAIHq0Fl2AcJ9MxkePO2BEF3U+Z2L4Snjonjc/Vm771d+
	 RrAAIlh9D8viCM+nvVRxQyZ+bVHnUJLAWqRA03f54WPlsJgtUc8oMYuv04uYkmG4vEWtO
	 1tonsYEDnWSnXCGIKGsw1kgMkubn+H/NWzvfwcVz1XtyH2bobkuyGU2iEDaM4862qIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581199;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vkoMBJPo+WdkqZ2neN3GroWz0YU+ZDiV2vvpQrhjj/g=;
	b=Y5tFk5gOAkeU9wsXqa2jvQMEDkCDi4id/sZ+9R5FtWHG/lhSHVFSsSfX1hSgnCp6IP2S
	 uxOg+mwCDSxZlJ9rwfvS3THsx0aKkg8yzEkvC5FL5fYAhjy7y3jQ4T0Wy1hnOY6/bSkwP
	 mZ9UTCm+RHz2jsEV95BoJur1eS+/5ed/2UL1MhD9ipUs1cTRBsfVwjFOJP0t/EsB4hpTV
	 Jp8USk9JriJVFZAQcL1TFmlNUw8tkbKA9JgWSvp3nss9CAvATfuRT+cnZWxFSpidL0za2
	 YjK539Ye3vFQgwqUH4LUMR3wMRmzGu/j4f2RvgOG+vWj2bLxR3Dgw70ULcmKJK4z/Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="O6Y/jLt+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A54606A32D;
	Fri, 13 Nov 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6Y/jLt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D42F1F000C4;
	Fri, 13 Nov 2026 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581198;
	bh=vkoMBJPo+WdkqZ2neN3GroWz0YU+ZDiV2vvpQrhjj/g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O6Y/jLt+a86yNC2kplFKwXNcKTytfRVKjRKGFCnS+RwVXNjyU9eijooU5uRPpnGyr
	 CzNvbDHEWNkG4R7Qyj+SrsId/vy4YlICBDEBmQFmdEP+JwcqLOHUFuWtm+NVSTmWBZ
	 hksGlgKSAPyxw13Ta7oMqYJEkVnMOcBuGJoxSrcgF/pxIArFaFAF1soJVrfq65Jz9Z
	 4lW8vfAgewvnHR1KLpFBtaoEzf5ClLl90Fyt0PpdDNdyISOORjFUzDI5u8kx/FkAYB
	 xVbZhPyAUu03SyCftI6sLhun0VGYXPfMfLMhu2bFdlrGsQmWqnLf54lF6w8Cf2wdtG
	 k0uVPrreEzLmw==
Message-ID: <84a4c113-e261-4802-9d61-4c7790a5d547@kernel.org>
Date: Fri, 13 Nov 2026 08:46:32 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] thunderbolt: Flush the ring interrupt status clear
Content-Language: en-US
To: Sven Neuhaus <sven-kernel@sven.de>, linux-usb@vger.kernel.org
Cc: westeri@kernel.org, andreas.noever@gmail.com, YehezkelShB@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1794520303-5758-1-git-send-email-sven-kernel@sven.de>
 <1794520303-5758-3-git-send-email-sven-kernel@sven.de>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1794520303-5758-3-git-send-email-sven-kernel@sven.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 15:51, Sven Neuhaus wrote:
> On hosts without QUIRK_AUTO_CLEAR_INT, ring_msix() clears the ring's
> bit in REG_RING_INT_CLEAR before it schedules ring_work(). This is a
> posted write and nothing is read from the NHI afterwards, so the clear
> can take effect after the next frame on the ring has completed. It
> then clears the status of that frame as well. The descriptor stays
> completed and the interrupt stays enabled, but no MSI-X is raised, and
> the frame waits until another interrupt on the ring runs ring_work().
> 
> Before commit 468c49f44759 ("thunderbolt: Disable interrupt auto clear
> for rings") the status was cleared by reading REG_RING_NOTIFY_BASE,
> and a read is not posted.
> 
> Read back REG_RING_INTERRUPT_BASE after the write, so the clear has
> taken effect before ring_work() looks at the descriptors. A frame that
> completed before that point is seen by ring_work(), and a later one
> raises a new interrupt.
> 
> This was seen between two hosts with AMD Strix Halo USB4 host routers
> (1022:158d, 1022:158e) connected by USB4 cables, running an
> out-of-tree service driver that exchanges XDomain requests and
> responses and moves data over its own rings. When one host sent a
> response and a request back to back, the request sometimes stayed in
> the peer's control RX ring until tb_xdomain_request() timed out and
> sent it again. In a request/reply test with 300 us between exchanges,
> 3-7% of the exchanges took the whole request timeout (about 75 ms).
> A debug build that checked the control RX ring every 500 us found
> these frames with RING_DESC_COMPLETED set, the ring's bit set in
> REG_RING_INTERRUPT_BASE and its bit clear in REG_RING_NOTIFY_BASE.
> The data rings of the driver lost completions the same way, which
> showed up as retransmissions after the driver's ack timeout.
> 
> With this patch, 6000 exchanges of 8-64 KiB had none above 1.7 ms
> (99th percentile 0.35-0.58 ms, before about 75 ms), no request was
> sent twice, and the retransmissions went away (84 in 1000 exchanges
> before, none after). ib_write_bw at 4 and 8 MiB stayed within
> run-to-run noise.
> 
> Tested on 7.3.3; ring_clear_msix() is unchanged in the thunderbolt.git
> fixes branch, where the patch applies as is. Not tested: other AMD
> host routers. Intel hosts set QUIRK_AUTO_CLEAR_INT and return before
> the write, so they are not affected.
> 
> The analysis, the fix and the tests were done with an AI coding
> assistant.
> 
> Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Sven Neuhaus <sven-kernel@sven.de>
> ---
>   drivers/thunderbolt/nhi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index e99a3fcc4a29..dd109f6ac70f 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -533,6 +533,14 @@ static void ring_clear_msix(const struct tb_ring *ring)
>   	else
>   		iowrite32(BIT(bit), ring->nhi->iobase + REG_RING_INT_CLEAR +
>   			  4 * (ring->nhi->hop_count / 32));
> +
> +	/*
> +	 * Flush the posted write before ring_work() looks at the
> +	 * descriptors. Otherwise the clear can take effect after the next
> +	 * frame has completed and clear its status too, and that frame
> +	 * never raises an interrupt.
> +	 */
> +	ioread32(ring->nhi->iobase + REG_RING_INTERRUPT_BASE);
>   }
>   
>   irqreturn_t ring_msix(int irq, void *data)

Even if this was reproduced using an out of tree driver, this does make 
sense to me that it could have happened from any Xdomain comms.  An out 
of tree driver just helps to accelerate the reproduction (just like a 
WIP patch doing the same could probably do too). I agree with it.

You might pare down the commit message and move some of the detail about 
how you got here into a cover letter.  This should be able to stand on 
it's own.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

