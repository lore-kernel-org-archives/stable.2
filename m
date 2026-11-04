Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830652;
	b=Vy2R4Fjq52JIqNcyqakQAiQb3vtdpt6O+CRipnRi+vEf+t9JOXWjnERiVw+lYEN6Gwiv
	 CII1ysjo5o5TsUIr3fMIiv+fkFQfXbfKrQRIb1xJqmyduy67+rigvu2/ybWasQNxy/4r+
	 OfMShz5jiP9a1MhC3i0DOFk10QPYreK85A2DyDHuPbUCrmaH3HrIxTT42GFNamucybWgS
	 xGdfj8G5ypYTy0fvSXG89hU2VDR0wzhOP76ZSkag6N5l3zKsMHw5Ilwn2v3niI0R3DY17
	 Tw05vROrK+NYCx1qDHl7Vfbop1cVLf5kOmwvJ//AOCfDKB+1r0iAuiVOwmOhtBom14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
	b=GWx0ngoiVJ+jF5sNl+XwcII19mTLOPOGHyfarJjJHSSGAOqZLWQjVTo8yUIcWSXh0U2u
	 XcKP434rkl3QVxjowu5YBedIH+Me61zIRe2XuXZixeZH8YgWQjkOjFXAIBSWveZg8m1Ml
	 velUc1YPY11IN3fWA1ZbSndxPfrthMYv78Xc8CJy++Om9ak8QcQAL+Z4KvFgOVcvTTtkZ
	 Rkl0oR6nJLnemeG+oJ8i/yS9B2o8v7GOpLuE6Rhncw91nWfGNvrLxQ356M7Qo9AK+bUGd
	 PSD/SzOHpt4HdmRoEgXSX26rqruWETwDDiKbBOnd9fMQI2kppO0Q5L8Wvj2FZRBO8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rq7jVyiI;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D37606B2D2
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87D37606B2D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rq7jVyiI
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-170135e43c7so1930907c88.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830651; x=1794435451; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
        b=rq7jVyiId5SSUWkNa+M8D63+z01CkI/0k/D5EN9jk6cghq65qdlCLjewI2YbHL8eVD
         TNSO1KguB2DBlQ99L4533C8P1Qbxi4dp+nDvx3kcsJqs9CHQOVjbf49hEVEuSIMYQMdY
         NznZjBiUfe8xrRU0NhCLFFPZSezS+s4/NWU8wLuN6ouU35FirwT4Yb+/+NCCNzWSiAT3
         ci9CvZb/hyyqoPMTWmxN6oN1cW9U3istGyfuqV0q03m0k6rzPGys7BaVTnRpJHmlO5nQ
         P03bfVHN7CZjy9X1fO6JeQk8FSW2D7KbedN0VluV1jWjS2muSMqlSe8zPofBn1GZPQBO
         WZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830651; x=1794435451;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
        b=mU0hXZBYBqTW41scye4FO9scwZjlSl/umZ4bM6j+yYAQ5UaRtdOps7iB0dv3r2EuEC
         9UxU+ZreECszJiYH5Je+UDz4K2cEzk69I/mZRn2LV3QXVQN8Th9QXtKwg4KG1zr6PmXz
         FXXT4fC6UhFd8av5Trt8eIJzDbfhD8thVJCg8Cc4HsA3XjUTo0Asc4TMbjeu2pBNafFV
         RlvhGXkQ/vo6SBIlRC9t2OV5tVXQMzso9LTmMMTLYFa9XOZQtmAQ3PoNl6RksqGGFp+z
         JF0a8we7/nX52eFPApZ7R5qypSVnmSEWoiD2LPEJUcoVbXIjMny0CjEjdwBkv9Uy0P0Y
         +HDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVrm3rPzdQxkXRUGbYE7aYdLY4i3fw/u+ZViX+wW952APWE8t8qEZ0PopgPOnOHX2obhETwto=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4xLrdA6TzAXUD5DZyu1VCi6OTDTIz7mHMG4qS0LdEgRUABzWS
	2+b9fyhRTzmNEQJzDVsRH7bEhT3sXYJqM0wZT1D7tCzwXq5CD/XmTU4X3rslSQ==
X-Gm-Gg: AYBFou3r+mTdkYn4xocqLbExUDomCVANjLd9RUaVaqQbZBt+zPilA18I0R3agNa7qfd
	BTlvs3IXEGl4N+XxV/dMwIIeqvM5uBAshD9STSxd/a2zSZzccBPfjrI6AW1OKW47HOSWZ4Kb8DK
	QlbkECkFFlPUfSgfizQJFdnFmRzDAytcR7y1OF6dw5EUrdfACeI3ziOTh6+VwcTs6LJaoaTVbjM
	qHgbEEgzGyfyp9Jweiof/yyUnx/vAx0vK8by5mVEFMWrqMTnIjVt8Mfijz/9BsXa7S5YLuV30oz
	EGokHXrhJ2qj6bHMVSFQ4FYKK+1sBpuzR7FtrBYka3c3wuIe37H9N9IrL/lXs/tkUvqpLF6bxyu
	LQcYPPZ8BB+441YaMy35XPZtAYrN7RKwApTLU0M0vgDkAPNenqcBX+QvWSCDMUWGahxNiOHfmEZ
	OlegW7BnyX2OGLkN3/By0PRU5jS/WFtD94ZRKSqckIo0iohxmgGTYhu7RB6VQ/fIy0jSM9upoN5
	qd1YV6bDM6W+OvnCJQNcdpc48NSdX5BMf4K6XrHZLu1u0JjPRc6lE1A6+kFu9xgo+UfI7WuyihZ
	d++rALRsCUWJoF6fq05WWHywGZ5sV4w1RoSTKae8fWQR8njwm+XbW/k60L0vUZ69onMfMkbQb6M
	WoDOGnXhmF3FoNts=
X-Received: by 2002:a05:7022:5f0b:b0:195:5b0a:7abf with SMTP id a92af1059eb24-1ac5bbb4cefmr23854642c88.7.1793830650490;
        Wed, 04 Nov 2026 14:17:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c463e9sm10646970c88.14.2026.11.04.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:17:29 -0800 (PST)
Date: Wed, 04 Nov 2026 14:17:28 -0800
Message-ID: <a27ddee4a4404e7d607b09f92924b2b7@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: adi - bound the two-stream packet merge
In-Reply-To: <20261103111714.472080-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-3-zhugl3@xiaopeng.com> <20261103111714.472080-1-zhugl3@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 07:17:14PM +0800, Guanglei Zhu wrote:
> When a second device shares the wire, adi_move_bits() appends the
> second packet to the first one at an offset taken from the
> 10-bit length field of the ID packet:
>
> 	for (i = 1; i <= adi[1].ret; i++)
> 		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];
>
> 	adi[0].ret += adi[1].ret;
>
> Nothing compares the merged packet against the size of the buffer:
> adi[0].data is the last member of struct adi, and struct adi_port
> holds two of them back to back, so an oversized length field makes
> the loop write over the second struct adi - its device pointer, its
> length and its packet - and the inflated ret later walks the reads
> past the buffer as well. The connect path also calls
> adi_move_bits() before the length has been validated at all.
>
> Reject a merge that does not fit in the buffer. Use >= for the
> combined length so adi_get_bits() can never walk to data[ret] with
> ret == ADI_MAX_LENGTH, and invalidate both half-streams on the
> rejection so the unmerged packets are not decoded as standalone
> reads.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
> v2: per review, use >= so a combined ret of ADI_MAX_LENGTH is rejected
>     as well (adi_get_bits() allows idx == ret, and data[idx] with
>     idx == ADI_MAX_LENGTH reads one byte past the array), and set
>     adi[0].ret = adi[1].ret = -1 on the rejection path so the
>     unmerged half-streams are not decoded as standalone packets.
>
>  drivers/input/joystick/adi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index e07b719..41262b7 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -168,6 +168,11 @@ static void adi_move_bits(struct adi_port *port, int length)
>  
>  	if (adi[0].ret <= 0 || adi[1].ret <= 0) return;
>  	if (adi[0].data[0] & 0x20 || ~adi[1].data[0] & 0x20) return;
> +	if (adi[0].ret + adi[1].ret >= ADI_MAX_LENGTH ||
> +	    ((length - 1) >> 1) + adi[1].ret + 1 >= ADI_MAX_LENGTH) {
> +		adi[0].ret = adi[1].ret = -1;
> +		return;
> +	}
>  
>  	for (i = 1; i <= adi[1].ret; i++)
>  		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];

In adi_move_bits(), length can also be 0 (either from the 10-bit header
in adi_connect() or when port->adi[0].length is 0 in adi_read()), so
please reject length <= 0 as well. It would also be cleaner to compute
the start offset (for example, offset = ((length - 1) >> 1) + 1) once
and use offset + adi[1].ret and offset + i in both the bounds check and
the copy loop.

Since you are hardening this driver against malformed packets on the
gameport wire, there are a few more bounds issues in the same file worth
addressing:

In adi_read_packet(), the condition adi[i].ret < ADI_MAX_LENGTH is off
by one because adi[i].data[++adi[i].ret] pre-increments ret, allowing a
write to adi[i].data[ADI_MAX_LENGTH] when ret is ADI_MAX_LENGTH - 1. It
should check adi[i].ret < ADI_MAX_LENGTH - 1.

In adi_id_decode(), when ADI_FLAG_10BIT is set, adi->axes10 =
adi->axes8 - i can underflow if i > adi->axes8, and for ADI_ID_TPD and
ADI_ID_WGP, adi->buttons -= 4 can underflow if adi->buttons < 4. Please
also switch the non-string byte fields and buffers in struct adi (such
as id, buttons, axes10, axes8, hats, and data) from char/unsigned char
to u8 (and s8 for pad) so their signedness does not vary across
architectures. Finally, the decoded axis, hat, and button counts are
not checked against the sizes of the static adi_abs[] and adi_key[]
tables for the device ID before adi_init_input(), adi_init_center(),
and adi_decode() walk adi->abs and adi->key.

Could you please fold these fixes in (or split them into a small series
if you prefer)?

Thanks.

-- 
Dmitry
