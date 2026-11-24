Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795551214;
	b=hzARiIoR+4o/5whWAO4kZUBUFCkxDSliOYAAPC4HuZ7MRfGdG1Q/iZWC3Hou01cK/lZg
	 dzkjy+bbYi+fVPyP0WyoZxOnc0k9fOIgyI8jbWffosctOdhLDsSIUScfloN3RoegyxwWy
	 4uEMnGALbng925EdsqJD9BRGKyl0BXbz2UI1sXjoqz5oJ/mWonzyFqHpt1+Ioarbq17+y
	 NMoUawsr7Bpikar1Hf1VjaIiBsjm/Qy2MbV075BlHpur/D/9oKSgb/X2usU2C/JpCryES
	 chj8/kBpCHSZmMv//J4NQUpBg5ykQo+tNe2TG4LkH+aFelpzCZROyCW/8zYCHlDkL2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795551214;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=0BBHhcvcX0NmOlb5zn8lXYG+5JCH/df9UZnJ1qUIA4A=;
	b=NYOVUKb+zhZagsBVMEc9sA1gmSdvZbT53IRefQ1YZS1mfPTuOtGmVg5oOXsbaW+JOGgb
	 e3e+2GYI984R5qxGxHcUqrXEEQFago9NO+5DG0Jlbp24XWueng+9IM75VPT6WBGl8NIM3
	 w4WraQXBoIVv+YAvQHJy8otKLM+oO3njo/dlupN3fnOWethHeR9RiyCUr6ycXzhBQTwTA
	 9HokIqwmY9eI1r2A2qg1N5/sHTTAxT2nQyY0jj6GKMWGodqL/SuCoCWfFdMNhATZZIUNL
	 ad7QZr55jdvh8UXR8t1UDFEC4ewPAgcrvlqdVuzcyv3SYJTNbX9+25dxMJ/RMyD68tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iPER3Nu4;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CA606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 20:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D8CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=iPER3Nu4
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso2296133a12.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795551213; x=1796156013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0BBHhcvcX0NmOlb5zn8lXYG+5JCH/df9UZnJ1qUIA4A=;
        b=hon2Uir2oFjfkWldwkMYQqx/qiqx8Ez+m+LtHWI2SzqkDNTW4K/kqilvLb6eZi/TEO
         TyKF5nOHCFAuYycU4Lt3Sz0X+z6m0qhc1cOCn6Xo07uYHbHLoahiZjrqCrlpkV8v+CLz
         3V0pfGoTfoOWSwNCv/pNGnSEFIYl2KG5n5/MpZgeKIy9w68YIw4DdIEseQ26ReX6PhkG
         BpM1hh9Bj3IcwE+NLKp5rhSfkgBaT+cQKocMQ+PlOO1a01/CT4XLQrCwGZhiYSWGABJh
         ZHEGH+oYzhlDKJ4siyeTE5YDyATYR9+Ywpntahh86UptCPR9kc+1RfoXUEhUepw7iBW4
         +PPQ==
X-Forwarded-Encrypted: i=1; AL+hErH/+vacp+3PAWvEk6lM89FX1HwONOXeQke0QmG/JRgUdgXtN4w0zvPGdEC0Qeo4+g418YyM5zU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rnVW25X12FRaZIxBrF+seAoue/BVLyLvx/rZRbwe8BcnxjVsv
	fMiVeZGKN4l/v4c807VbZjetylapIw3zHk3AMUJbEKP3O6FlLjoMpRb5puZYqgf0V/cgCReGrNg
	iimTLdY+wEVRG0h7ry2SgnoUv9/+IL4/STrwrfnrE68xqdB/37Vxp11vTlrKJlBnuQ4fJa5VoBz
	E7Z46WsLxEuX4nJUlYwDvy/XalcHFER4YLEfrbAdacytuf4TIkXOJOoctG5j2HSh1f5r9xkF/4y
	1zgE4Ys0e3TG3Sr5Q==
X-Gm-Gg: AZFdTZdfuwWTQofDm+B1XMn6EtdGHakmPGkbz2XBYtnfPaeoax4CQpV/ICn9CdYILj1
	Uj7G1wsZOAXOXKR2BrJQzuM0Z3Zh4QLGdjvpug2wLKlvaYiGk9W1uv/XDruvaBkNLW0r1irEfg2
	je+g0NVdIQa0hm3HHvCocNPCTGPPm4ugPARPjXGE0DbbQ3qomPXjtj3tCXMytiaretE+6lHFUbq
	MX1c75V1wTw/rshW+kYn6XNIuE7x6QfqBTDrdATvAxJH9Txahk/hwsIm5aKTHRwqxHVuONvMwAC
	X2NJegL2gwKWNKXndjaciUQYGBeZ219HiIHDmaqLBxN9iGHDkl/xbpsFqc3hWGk3GUQSXXKLXA+
	KzlV05U++D5t1G8kekdKxIL0uVoS63rmRcbHNTpK9/44p8DCZhkgta7jNHVcemAHc3R5UtaxEfP
	3resdp+nz99XJF6hAa//9C8tSDiAcZLbx7E05V/rY=
X-Received: by 2002:a17:90a:da88:b0:3ac:a11a:7c84 with SMTP id 98e67ed59e1d1-3b41c982dafmr14176440a91.65.1795551212559;
        Tue, 24 Nov 2026 12:13:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b4062e6c29sm12301754a91.7.2026.11.24.12.13.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:13:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-94960131b4eso32803285a.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1795551211; x=1796156011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0BBHhcvcX0NmOlb5zn8lXYG+5JCH/df9UZnJ1qUIA4A=;
        b=iPER3Nu4r5LT6OZnZ6QsyFZ5zgc0WpUwgxprR8WKSlU7h9ggDx3fozfUwIWdjoqza8
         3zlpPqddV5ACbN3iwC3eq0Vuk0XeqqY8XhpW5cGm05sKAg30VyElaJnhAOrzGajBlaje
         ten1Jz0hfaQg6pxKOjcD7f43RO6BN3m8pNsVM=
X-Forwarded-Encrypted: i=1; AL+hErGM7V3dJVFLHgyetYbkqbxiHwV3LbSv1q4DE6XwmbSDG8mwQ6iqNfbIpZz8eyjUUyCJFECTfBM=@vger.kernel.org
X-Received: by 2002:a05:620a:4625:b0:949:6d95:f63c with SMTP id af79cd13be357-949bab4d95dmr2635394985a.56.1795551211441;
        Tue, 24 Nov 2026 12:13:31 -0800 (PST)
X-Received: by 2002:a05:620a:4625:b0:949:6d95:f63c with SMTP id af79cd13be357-949bab4d95dmr2635390885a.56.1795551211025;
        Tue, 24 Nov 2026 12:13:31 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34ac1esm1127270385a.15.2026.11.24.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:13:30 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Shirong Zhao <shxzhaosr@163.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] wifi: brcmfmac: drop glom superframe on header parse failure
Date: Tue, 24 Nov 2026 21:13:27 +0100
Message-ID: <20261124201327.3491419-1-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116041534.24-1-shxzhaosr@163.com>
References: <20261116041534.24-1-shxzhaosr@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, 16 Nov 2026 12:15:34 +0800, Shirong Zhao <shxzhaosr@163.com> wrote:
> brcmf_sdio_rxglom() uses rd_new.len_nxtfrm and rd_new.dat_offset
> right after the superframe brcmf_sdio_hdparse() without checking
> errcode.  On parse failure those fields are either uninitialized
> (the early -ENODATA/-EIO/-EPROTO returns) or hold a rejected value
> (the -ENXIO bad-offset return), so bus->cur_read.len gets garbage
> and skb_pull() runs with a garbage length.
>
> Check errcode first and drop the superframe with the same cleanup
> used for a bad subframe below.
>
> Fixes: 9d7d6f95bda1 ("brcmfmac: streamline header parse code of sdio glom read")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shirong Zhao <shxzhaosr@163.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend
