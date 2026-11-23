Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476845;
	b=xhlWLIWTchAI30/PwCP3QuFZ35gSzpBUWRwKVjtUtOR5/QwKmrJ4cAEcxySY2B72dkL7
	 WZ4C5PESSQkKhgsZOjlvXi7rt8ASW2wQOhfXj9XKBlYHl5zkZ+1tgwCbLSn/8uA8vHbLq
	 lT0Rt6CNm5wSdk58YR0l28Q2T3/4OIhgnuqqGcSxgBLELQ+lxd5MXtUU04k4uGdY6NkYO
	 fxodnTXvThdBjvAvsfSwMp39PXwBnFAHV+5sePr7LekP0k7DDVPmsckJckm1PLfdZD59C
	 BNrUgdzIVdbTgbjWbTLHPf8KFOO2qJEViNEqTDlHFzUY0KCUL2zBd5B64+YlK6ktTDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
	b=x2C2hVsm4QmjSAitZQqmMZzX7GVCKWR77sP/buyvKEuFLQCLp5NbK6MQh6PFfyvs+Rsv
	 4pLdxaTM8c8VP+Pkrlu26dDZ+hD4jum0FzXgT/6yphlvc+Ex/uy4z0FguC0YfRR/coVBr
	 N9wIslG3cqHwGAjDTUaRJVbFfjeVwKJZB53HeF19qjFVhl1VOjWqBE3V2rmduFSWyyT8O
	 zNIKPQC9vtmVV9486bJA8lA/1tX5AauieSfWpVq58552PBcLm/PsY4k4HKwYcO1V0uoj5
	 UXUqPHv172hEOiOsgcgmOpCn13uKoUAULGu7g46gBSVi/ZvgJBRMBnTm4l1HnPGk1tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YN6bU/nl";
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FFD606A322
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 23:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3FFD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN6bU/nl
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a2af4c8d00so499171c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476844; x=1796081644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
        b=YN6bU/nltpD1xwu/Qd9NYjrVRFb0k2cJwke9ul+mK1BCcleQioDj9AR/C0s4c7BIoJ
         ew7gbesA3mNrTgTtc17FzwLrLVe40CtHlE1xS3y2EoQQPgIUgkUGq1kY6tmcr4NDwkyK
         619PYDPFWDC7jEVK4gUdsRqSHK1GzylbfeuP62GS80KYMCrPcTsIZryAPVIV1Jp2019z
         CnxcOx+l/Vz+1WQskHbW+hmBVm3gcfULXmavtkpG/6hUP81jNvEaUr4uW9Ms3IikJcvp
         YL9dUIPsl4mblyDjDgVKMcmsVj7EagB+MI3hJvuiNCJ5E4xfd2LLN7y+eYwr2oNdgZi2
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476844; x=1796081644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
        b=kFj6i2bCwFSXx3z4yL6gD2EsTMDSkbzAUWIUHpnKzDCSkQk4MbFKiOGvXb4uWf7HsF
         5kMtm1tHQfnnzTytzIN4SKSIlL54KWN6lCpPuR4FdnPg7bl6ko2ohdSSWDNTS+tbcxnK
         NSadr5AYGO666vB+YWRNZHN0C9cIK5j43OHcm93f85+XyCgeFc8P6XLEbSNJmHD0t7y2
         yK/LevQD9WZ2FxrU0bQ7j3XgxprvE44JejU+L/KA7tIdYXqporwmy3YKMkDQKtbd3JOY
         UUKaz0sChXjLAfD3HyLGrRzD33Ccc2PEaQrvqwhnJXSHt6/4y46S7vR9IBic0mhdIpQw
         j5ig==
X-Forwarded-Encrypted: i=1; AL+hErHxA10yRdAtkef3BoJduQLNUgZScYNhRDEISLIKtTfWv17uLkQZFZy9dAXWzGqDQl9Gqk/OBHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+G5LKPZn6kI0dpYmzUVhiDeJ4viRxGmy5ZC0hCQOCrk22h8pmp
	E6CZQBg7i0fBprUJ61sgFFumJ515igIIPMrrVHCWLne/RadkqEDelRRx1XARZwTC
X-Gm-Gg: AZFdTZcm1JUyRsgbjgopWz5ZFTxBLdwCprt0nqRdepQ87qE5Gd7wR/hjMJ/pLQpL1ok
	QnEP3T+KsL+uAKvODMuopQM9AAmAfxOaOq8TlgSCjCcORbKz1DuaDtKE3hQUZQY/gxCjtzko+Oq
	5CwSzEwNcchteBgz4f0Xjd3mCerr+xVtVr4fhW741r+v2L3Fzy9NMS2aA4dMDYkbMDh25U7eUMA
	gFHIHqAi3NZ2BBRhGqD3gWaeFFzLfus5/eiwtoYp1LDkCaRv6/m1RMKixNEO4KNyHo2/0+OHWBy
	Npm+4+0VZ44G+HGprO/q2jEsaAS0PEyoEwZxqJkhJpTYzQoDolfgRxy5ZwFNbfUEPIyocCdUJAE
	2OPU21PMLAO/rBZ5FN2hOE+sqcVJmAKDGZxVBHHhB3ceK73x3q4iAyxM3j2Z1XdxRBiVBFUuIiD
	HtBAfYl2PRuQKllAVxA0kDqd/QEzPqD01bI+7Yeig058w9pWytajKIwiNypYcg4N5JG2wS5N8rm
	E9tqTdfetxSHSWQeMuKFK1z9f+FtRigx8bro/BEk+WbKAWdTsKOaWas/L2qtVQn2gIwmHnwvFkD
	NkGGKTpn9kZa/4qY8qnEVdBtrMcZT7UB4bZuExDzydYFZWBH56N+cZdx8i1QCfuJvUE7QJY=
X-Received: by 2002:a05:7022:ec17:b0:166:862b:9bcc with SMTP id a92af1059eb24-1b55689ad7amr16499755c88.18.1795476843673;
        Mon, 23 Nov 2026 15:34:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm32516558c88.5.2026.11.23.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:34:02 -0800 (PST)
Date: Mon, 23 Nov 2026 15:33:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dudley Du <dudl@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 02/10] Input: cyapa - validate firmware image size in
 cyapa_pip_check_fw()
Message-ID: <awTNTSz5mxJ_AaME@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-3-lee@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-3-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:08PM +0000, Lee Jones wrote:
> cyapa_pip_check_fw() parses the firmware header, the trailing
> application integrity record, and the application rows without verifying
> that the supplied firmware buffer is large enough to hold them.
> 
> A truncated firmware image smaller than struct cyapa_tsg_bin_image_head
> causes an out-of-bounds read in cyapa_pip_fw_head_check() and can
> underflow the unsigned size subtraction in
> cyapa_get_image_record_data_num().  An image containing a valid header
> but zero complete flash records causes image_records[flash_records_count
> - 1] to read before the start of fw->data.  Finally, an image whose
> metadata specifies an app_len exceeding the available application
> records reads past the end of fw->data while computing app_crc.
> 
> Validate the header size, ensure at least one flash record is present,
> and bound the application row count against the non-integrity record
> count before dereferencing image_records.
> 
> Fixes: 5812d3067294 ("Input: cyapa - add gen5 trackpad firmware update support")
> Closes: https://sashiko.dev/#/bug/linux-cc76de59-950f-4e64-b49e-7605164e02a9
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied with some minor edits, thank you.

-- 
Dmitry
