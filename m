Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465762;
	b=HXUD99/sleIht4ijDDEIzjNgobe1nFM3tb2LvwOjijKAJumXHcv7yZRo7Od2pLGDZ+uB
	 6AnhpwKbviEA+ADJWaE1+Cgi//pBqmeoe3vC6AYJwYRJ/ufEVn3nLg8fPkqNawr57PciP
	 6x3WKGOjA04IbMH7Gz9T4/wGMR4OP9+Jei8nrtzgeDdKsbhH/RG8t2hzDdZ6WfBfzP8ck
	 U6ty2P+ZWp3+SwPGEe7EX0YUQqzmoVzRnrSDgO5twupUPWOtqdy5oYl9jw//OtLeXS5GF
	 NjeIjp+07lGExRbvEUbExJWxrJkAoCb17SE4FDDhDGu7saqKwbPNA5fUrmw3s+fUuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=dTSpWgCuU+uPZLriefRpG7c7+1TKz+jm36CBK/vsWJk=;
	b=wXee0MqvZbfBJ2IvZALYdfsIbnP8Nl/lZ9jxaSm3zS5kkAZ4zbatXoT7ZivQKtKFGYlF
	 76lC2A2a0pmUvAc/z9UBpdyNChuD+vPkk/sCl2JfTeOLTAmBNSXtDmtDHIEXuiV6FxIii
	 b/REMHkFjsgLN8+/C7EOoENuph4Jf0AwfM3ayuX8z7KKl1WGoJay5HsOxgm6XqKLr8JpL
	 6VfP3DRFnD0/3nppvU5X1XootrHu9hCMxKpbSN8UUyDx/2DOzmVubLiJ5eZbh4OCwVs47
	 0tdNSQwA9idKx5IW9JRh0cZ2W8U5GDc9EAKsaqKchYtExK/1noWsvI3IpuHo6/jOr8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=REnspDXt;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53016606A31E
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 16:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53016606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=REnspDXt
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1471379c88.1
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1793465760; x=1794070560; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dTSpWgCuU+uPZLriefRpG7c7+1TKz+jm36CBK/vsWJk=;
        b=REnspDXt+lRcxcp94OICDLypGbuOKyCjYRTlZ8QxpOGOD/WcUbDMN8O87C0EzS5UbH
         MQ4zjwmACZ/pc67zk2cSLhpLFdA/fPA2CijbU5WtXW+A4anQtI977v6hGmbFP8CAVVbG
         VeOE/gGNtxRthMf33tWZ6UY4ItrNj/LdHDtfulZtzF82/dqO7e6ppHfP95h+EqkrZgQm
         tFKGT6wZpO8Oew+0k3NsoOYHf148k6g8PFRY/DLQrssuXEME11rbKsfzQQ9bOF4HyYQl
         ZxeHqNAkvqaMdt1FXjihcuQZ0kT6wvgGewF5IMb7pOmNBK+g9R4V+K82agU4w5nD4Awk
         IaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793465760; x=1794070560;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dTSpWgCuU+uPZLriefRpG7c7+1TKz+jm36CBK/vsWJk=;
        b=O/OKRDWCymlyAozRh7+m81WPBWY3qb3n525foKpMuGf8T2i0RGqUECj04/yqfBgvSm
         SvIomDiZ/+nLKVl+uOEL/qcdeoOEXKfZLno/4eYo8l0rZoBtx1/1DTDrgR/FEvUjJYlj
         UO7z+MWIiyAtRDmmf4bnaohU1GU5PxWDAweUGKnk9Cp43yjpJGTa0VRB0DLC6wqc/w2Z
         vdu5ehx0mVAholR8vBafd/owOWvb4aizCPczQ7nLG1uKh5rhh6l9tL8I0OfOp93mrURV
         WC9xKYwn/325dfptzyWPwFaO9mXxh0q9bg9fdX9ocAmpLAOi/knduPCtpmNMeKGCbXJy
         ke3A==
X-Forwarded-Encrypted: i=1; AKwUvBxrs8WWy1IM7vi6LbX40mrw8/GND8EmpDewopJgpU5nJGVGgiqVIMtU6fx96voUW5lYrRB8Hyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc0GSALq0+ZmlRdvYxfKdNAEWehDoPupa+WNxwdhOg4ioWttkE
	tXbtBngpf6gu24bV/+afwb3jo89Hj+Wz2/aYq8EnWvzhYlfoVAGVLFSKLHLea4LK5nSTFXnlH9g
	YfRMfdNM=
X-Gm-Gg: AYBFou1qdKMJLX7NjIyRcbuRoukK+k7zT4OLqp9Ep9gSB6DDwzDZffAep/wLhgA+raS
	wzpG2OLlgZhDjVPv8Lwm3LgiOLwgAV7Tz8/2L88pvvlbznmhaP5llJKevZg2AA9ywEe44GFBgLk
	HwhE1HPU0gyt+wEH5HK92PYf9YdcRka0CSVQAGJl4kVRBJtWdsoTyFfrCJp3RqY5aeaDbt3YaQC
	YFrE2zKA41MlULDmarm7sLMhkD/2+/V1oy/thZWjMMaaPdsMfGwPrhWgmue4GdtK2Tz4T82o6Kh
	r+KXhFfTpn8fyV091ZcGLR6EBV7ZiEZgfIdUE69njC+40am+2fmyVtB6TkMNFBXz8bTwvCSQe4W
	6UJf4sRriEK/IBRroQZ8AEaKPhDRm0mCdmAGfyswXHeVl5l67NFNIU4OMGp6rKfSqRXEzCVBhAi
	Tef5KGbeW1ncwmhKP3hZiLtQkIql88Z2TXRuHblVCU3XWC+xd/AWjg4LLbYvO9GFeV1KEgIRvSM
	BH+nxGTsl9rPxRMw1wzjhKItueWCg/B1v7L/pwcgMzJKBHtFRqQp1VQoe4av0DTTF/4YQ6ALGwt
	pA5KscdTpE3+P45dXRck2/tasNQ+zg==
X-Received: by 2002:a05:701b:4517:10b0:185:fd0c:4585 with SMTP id a92af1059eb24-1ac5fb18de9mr7587298c88.33.1793465760211;
        Sat, 31 Oct 2026 09:56:00 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm17690437c88.15.2026.10.31.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2026 09:55:59 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Oct 2026 09:55:58 -0700
Message-Id: <DMJ6JVD0I6KI.2DKEVAB8RYTO4@nexthop.ai>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sasha Levin" <sashal@kernel.org>,
 "Siddarth Chilukuri" <siddarth@nexthop.ai>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] Revert "i2c: xiic: defer RX_FULL until all trailing
 bytes are in FIFO"
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>, "Michal Simek"
 <michal.simek@amd.com>, "Andi Shyti" <andi.shyti@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>
In-Reply-To: <20261008-i2c-xiic-block-read-nack-v2-1-76735ed0b0bf@nexthop.ai>

On Thu Oct 8, 2026 at 6:01 PM PDT, Abdurrahman Hussain wrote:
> This reverts commit e6fe3ea04f0113fe4d47c03d76e03805a4768ca7.
>
> That commit raised the Rx FIFO threshold for an SMBus block read whose
> trailing bytes fit in the FIFO, on the grounds that firing RX_FULL with
> the last byte still in flight made xiic_read_rx() NACK, and so truncate,
> that byte. NACKing the last byte does not truncate it: it is how a
> master ends a read. The byte is still clocked in and is drained on the
> bytes_rem =3D=3D 0 path that follows, which also issues the STOP.
>
> What the higher threshold does instead is skip the bytes_rem =3D=3D 1
> branch, the only place that sets NO_ACK, so every trailing byte is now
> ACKed. Having had its last byte ACKed, the target goes on to drive the
> next one, and the STOP that follows lands in the middle of it.
>
> Some targets ride this out; others are left wedged until the next
> transactions clock them free. A TDK FS1412 fails the two transfers that
> follow any block read, so it never probes: pmbus reads MFR_ID as a block
> and then VOUT_MODE as a byte. A Renesas RAA228246 and one RAA228244 on
> the same controller fail the plain block read itself and the byte read
> after it.
>
> With commit b7e6df2f52ed ("i2c: xiic: preserve PEC byte length in SMBus
> block read setup") and commit 840d8acc8792 ("i2c: xiic: don't clobber
> msg->len to signal block-read completion") in place, PEC block reads
> pass at the original threshold. The PEC failures the reverted commit
> attributed to the threshold came from the bugs those two fix; all three
> were developed together against an ADM1266, which rides out the extra
> ACK, so the regression did not show.
>
> Twenty rounds per device of a block read and a PEC block read of MFR_ID,
> each followed by a byte read:
>
>                before                      after
>             block  PEC   byte after     block  PEC   byte after
>   FS1412    20/20  0/20  20/40 fail     20/20 20/20   0/40 fail
>   RAA228246  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail
>   RAA228244  0/20 20/20  20/40 fail     20/20 20/20   0/40 fail
>
> A second RAA228244 and an Infineon XDPE1A2G5B passed every round before
> and after.
>
> Fixes: e6fe3ea04f01 ("i2c: xiic: defer RX_FULL until all trailing bytes a=
re in FIFO")
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Cc: stable@vger.kernel.org # v6.3+
> ---
> A follow-up to my xiic block-read series, now in 7.3-rc as
> b7e6df2f52ed, e6fe3ea04f01 and 840d8acc8792. The second of those
> stopped NACKing the final byte of a block read that fits in the Rx
> FIFO, which leaves some PMBus targets wedged for the next couple of
> transfers.
>
> Tested on a 6.12 kernel carrying that series, against an AXI IIC
> controller with an FS1412, RAA228244/RAA228246 and XDPE1A2G5B behind
> it, using plain and PEC block reads and the byte reads that follow.
>
> The same happens on a second board, where two of four ISL68225s behind
> the same AXI IIC core fail plain block reads and the transfer
> after them. A capture of SCL/SDA taken inside the FPGA shows the
> mechanism: after the last byte of an MFR_ID block read the master
> drives ACK, the target starts on the next byte with SDA low, and the
> STOP the master then attempts never appears, leaving SDA held low. With
> this change the last byte is NACKed and the STOP is clean, and all four
> pass.
>
> PEC block reads do not regress: 1000 PEC block reads of MFR_ID per
> device, each followed by a byte read, on the FS1412, both RAA parts, the
> XDPE1A2G5B and a further RAA228244 passed without a failure, both with
> this revert alone and with Siddarth's patch on top of it.
>
> With this change a block read ends with a NACK, and so with TX_ERROR,
> like any other read. That puts it in the window Siddarth's patch closes,
> where xiic_process() sees TX_ERROR before RX_FULL and resets the core
> even though the data is already in the Rx FIFO:
>
>   https://lore.kernel.org/linux-i2c/20261005-i2c-xiic-rx-fifo-v1-1-0177ac=
5f72d7@nexthop.ai/
>
> The two touch different functions and apply cleanly to v7.3-rc6 in
> either order.
> ---
> Changes in v2:
> - Revert e6fe3ea04f01 outright instead of moving the threshold back by
>   truncated), and with b7e6df2f52ed and 840d8acc8792 in place PEC block
>   reads pass at the original threshold. The code change is the same
>   single line as v1 minus its tail =3D=3D 1 branch, which could never run
>   (Siddarth, Sashiko): reads with fewer than two trailing bytes are
>   padded to SMBUS_BLOCK_READ_MIN_LEN first.
>   Sashiko review: https://sashiko.dev/#/patchset/20261008-i2c-xiic-block-=
read-nack-v1-1-94882af6e598%40nexthop.ai
> - Link to v1: https://patch.msgid.link/20261008-i2c-xiic-block-read-nack-=
v1-1-94882af6e598@nexthop.ai
>
> To: Michal Simek <michal.simek@amd.com>
> To: Andi Shyti <andi.shyti@kernel.org>
> To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> hand: that commit's premise was wrong (a NACKed last byte is not
> ---
>  drivers/i2c/busses/i2c-xiic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index 5e397a7e63f6..76ef9c26ed57 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -569,11 +569,11 @@ static void xiic_smbus_block_read_setup(struct xiic=
_i2c *i2c)
>  			i2c->smbus_actual_len =3D 1 + rxmsg_len + pec_len;
>  		} else {
>  			/*
> -			 * All trailing bytes fit in the Rx FIFO. Defer RX_FULL
> -			 * until every one of them is buffered, so the drain
> -			 * takes xiic_read_rx()'s bytes_rem =3D=3D 0 path.
> +			 * All trailing bytes fit in the Rx FIFO. The widened
> +			 * condition above guarantees rxmsg_len + pec_len >=3D 2,
> +			 * so this cannot underflow.
>  			 */
> -			rfd_set =3D rxmsg_len + pec_len - 1;
> +			rfd_set =3D rxmsg_len + pec_len - 2;
>  			i2c->rx_msg->len =3D rxmsg_len + 1 + pec_len;
>  		}
>  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
>
> ---
> base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
> change-id: 20261007-i2c-xiic-block-read-nack-d2b735baddd3
>
> Best regards,
> --
> Abdurrahman Hussain <abdurrahman@nexthop.ai>

Hi Andi,

Gentle ping on this one. It missed 7.3, so v7.3 and v7.3.1 now ship
e6fe3ea04f01, and any pmbus device on xiic that reads a block (the
FS1412 above, for one) fails to probe. Could you take the revert
through i2c-fixes for 7.4-rc?

When you apply it, the stable hint should be

Cc: stable@vger.kernel.org # v7.3

rather than "# v6.3+". Sasha dropped e6fe3ea04f01 from the older stable
queues, so 7.3.y is the only stable branch that has it.

The patch still applies cleanly on current mainline. I can resend
against -rc1 if that's easier for you.

Thanks,
Abdurrahman

