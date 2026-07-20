Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3756838B154
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576953; cv=none; b=XT3MaS/LyW37bc2XAAR62JPxhaSnlcUBXr+pTVSdchaZ9r81ClOWrAScaAZBvFasVcMeKWymRw1UtKLGFly8yUV7iUwD5sIbn5LVOIMtJbVhZjBwGD7cY2QLWjqAd1ip3skDg7c93qLJVxerq2kgOEHb3GxoAv1O07n+OISp9Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576953; c=relaxed/simple;
	bh=Q92lWuMn3xKdUx7myg0r7cLEvOzGhk924wJFAIzX4Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9CZDusaurRllmwFwn5rasY0m9M1UxIooT/FdVA6WGodLRITrQZ/fRCBh39J1+UHqa2N9kkyA89e6Fg7/6JQia3lfFhNqCM2tj1DXxAmrMwnVaq4lU1qRObVpawMeRomIl4Uds9NicIA93p2R4T7/bmAqEHQbOiJzwBY4Priiq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hZ9LpQNM; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hZ9LpQNM"
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-738b39dad22so2530474137.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576951; x=1785181751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKqBGdGQQX6H/zEdNMKQSXypwrRgUjHCTJhDmIBT1A8=;
        b=iCpV8NH134Sup6FXxAPKMsd1q7jIJ6Y/jjKtkpZVX+wMMw25Z02GsX2pVW/NJ942Mb
         my/MOgRjyfIJ0UoDxhpMcDhjneW7n88+CS1e5wXaydbSazjwHlnVd2YdXz9/KpyM3HSJ
         Xg1ZKs4t3rn4qUuOJgdKl0PYbRLTl/OkSpZ2IKmpCd775HB2s0Sn0N+QNq571WG2TvA6
         pN0gTRUycmN0X7b8M5MhdTIhCm2QvvSIpWSvIuvdOMYKSpl5wpfUdemUcBZVyoEqvSP+
         azdH7YTDh5YDBh9mkSv/YDcA/0oQAc31qvdM/Mb/TVyx6lXDfdw8Is8NWVst8DyIHbXl
         YYZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPFIgn2Rfb1RiDVeJjz1edwtj71TtKrNKPnLD0VXXoGnicnZ/mm4PNxg+MaHoM2nIZC6lG05k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5T1x2ZkjWfEg7hPNMn2X2QgHmYMKHs9QXx8AFBc9/ezNeati
	2S7Tdakww4TBYgvposYaivTvck+De1koBf9HEJqZlqohhpS3UtCQ9Lf0gTKom281t1xkO944Yyq
	kcSCBpJXdyPWlMPuVSXmBlSPx6DSV3mUfBr3AN/aUg1cvTqhoCL4GnbX9c4/SUVKROjZISBiZGA
	4WZKh2haSDgeomNCpVghFhh8lvhaMdTczFJRLVuPTAMwJn96EtxPLFKkD9me+uN+5ardIfqMnU9
	5/UjfPV5Wy+2prG6w==
X-Gm-Gg: AfdE7cksRuJ53DmRRv4On/MdXCcpacfWsW/RkQDWXA7TJGVp+NjSYSKijllecEZmpq2
	z3kiDhjDMdl9tkb3D4jnihuzCrMvMfH6eE9uvbKrLyv8E13Noja8gkL679Mvlc5Cf7KVxnRhVXq
	QTHYEhX2FtNS1CWHyXxIpecQns5f+tIjls66gtaljANjfsPHrde+ij6C2NSaWt7sHJWFwE+BBOY
	5hADsQAAN5EBvLA0/f2kxmCzfosIlX5Sw1ZNcxf3TadQZKL6s7ntzfyYkl9eErRNtuuSaaWVUfk
	n7b3AsgB3LguSv+ZFdkwfn7/dChFOJeji44L6PSRX/3CGMZYFKZ6Un9RD8eEzi8KZynf5tebHVN
	6QAPbKl/bm3dSpMHKzqKZ++mJzQu/Fx385atSpIr9D2LLaE2ZlXm1W/fVXODJk2gi20qOMm3kmQ
	J0TiK1L2t4EQnMHZJBylGRUz/oRcbqoE0PXOQS1h72xw==
X-Received: by 2002:a05:6102:d88:b0:738:bf0f:d0c7 with SMTP id ada2fe7eead31-74753744808mr4570483137.25.1784576950983;
        Mon, 20 Jul 2026 12:49:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-747581e6a65sm773921137.19.2026.07.20.12.49.10
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2026 12:49:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6986557937eso6039386a12.3
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784576949; x=1785181749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKqBGdGQQX6H/zEdNMKQSXypwrRgUjHCTJhDmIBT1A8=;
        b=hZ9LpQNMVh+HsINRWBVvrIwc3Lpdk2zSKfR0IwFGO7QZEawy2je+Nbsw647unAx/VX
         yA/BeyAnXTotX6QFY1fyxMhlTO/79B2ljv7ds565QoLajQo0LEA0EBNFLZnO/O5x4dI2
         tPx/+3GTbzbMlarVGbesm93Ek8xMJjYq3JOWo=
X-Forwarded-Encrypted: i=1; AHgh+RpIBTeko43nRyp2k6FEBWYUK9eYJ95XopSBGkHfB/dxFa5zLksapXxwpQ6ymHdJRe5jf5/QxEQ=@vger.kernel.org
X-Received: by 2002:a17:907:c896:b0:c12:6ad6:6398 with SMTP id a640c23a62f3a-c16b4854d08mr545723566b.34.1784576949516;
        Mon, 20 Jul 2026 12:49:09 -0700 (PDT)
X-Received: by 2002:a17:907:c896:b0:c12:6ad6:6398 with SMTP id a640c23a62f3a-c16b4854d08mr545721766b.34.1784576949094;
        Mon, 20 Jul 2026 12:49:09 -0700 (PDT)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705912972sm506543066b.14.2026.07.20.12.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:49:07 -0700 (PDT)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: LiangCheng Wang <zaq14760@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Angus Ainslie <angus@akkea.ca>,
	Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	Wig Cheng <onlywig@gmail.com>,
	Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
Date: Mon, 20 Jul 2026 21:49:00 +0200
Message-ID: <20260720194900.2356442-5-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715-b43752-f2-blksz-v2-1-f9be49856050@gmail.com>
References: <20260715-b43752-f2-blksz-v2-1-f9be49856050@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Wed, 15 Jul 2026, LiangCheng Wang wrote:

> [PATCH v2] wifi: brcmfmac: set F2 blocksize to 256 for BCM43752
>
> The BCM43752 is not reliable with the default 512-byte SDIO function 2
> block size ...
>
>  1 file changed, 1 insertion(+)

The stable backport explanation is clear and the "needs adjustments" tag
format is correct. The one-line fix is trivially correct.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

> The BCM43751 shares the 43752 firmware handling and F2 watermark case
> and may need the same fix, but I have no 43751 hardware to verify.

I have a number of devices but no BCM43751. If anyone has please try
this change and let us know.

Regards,
Arend
