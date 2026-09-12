Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A823451C8
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789196115; cv=none; b=SYxa45CaAV+3XEXAuwhJaC9B15dsdHNgpmnKBE7bt4/OKqt0KjoET927P/pZ0BwWjWIrJR3aai8lknQY3KRppT2JQ1lFLssiOSR+CTuo2NlfLFsJnb2ta0FQeoM7Qz/L1rJusBaXn7DwFdC2PdiZeJvLbp6RN4l5kFOaSuDyvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789196115; c=relaxed/simple;
	bh=8EB250JlF6h4Nml+6sYEobeY/gwdRlUb4QTBCsN0GJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idP6IjUzmLJKArzqo0D3Oby8o2ldTkJ73O59k/ZZeHVoH8cBvpfKhPOTOgVyWw7xJr1o7TgkVGd0/sET8vfvyCQ5Rq76uvI+Kpd2R0U2MenCI8i08WF6MqehmYzIN26E6doIgK+8z0NFFN6+H8PtwbXIoOxZv+wBOBc2f1yOIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acFhQ09y; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acFhQ09y"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2612205e9.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 23:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789196112; x=1789800912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8EB250JlF6h4Nml+6sYEobeY/gwdRlUb4QTBCsN0GJs=;
        b=acFhQ09yM6XEmfXhcn8vAvRM85UYqu4WMM3Fbkpe1pSFvF5aaGBVZlM5RZnVDek/b8
         0tlIvFoKchW7vVnAMlmxo8Oiqb1Zsu0iQSUfACwxuHzYqRmrBWSef3JwsHQivo0m+gGV
         NBgngNgLJyT+diQiaLIo+Eqzv6gzl8TaQvZ/PAqhuC7e4WSVJdUml7C6xMOZD3uo++jy
         ebHpPqKZEyq84+Tcmh1AJqEaUnsm0pyI5jWTJwdwgaHwI6Ad2hOTXVceBdQuMocw09VV
         tEF1jYoplIvT/2MwUO2fXJjCAHj0T+K5jIPDux9E75AroH2ImekXurusABR+0BsBR6zq
         QLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789196112; x=1789800912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8EB250JlF6h4Nml+6sYEobeY/gwdRlUb4QTBCsN0GJs=;
        b=XDeMVdtPHRFj0pW7rvQkr+qTLN3YHcTAXcqD1IBCLvJOA+/7s2KqzfvakF/OS0mq8d
         zy96Ije2L8SCK/KEcbU6fOwHNCJkKXE3OOZcnqP8P1Fn190fsywa5hjByy4/dxZ9awRc
         B9h5lFmCMOHcXTedTaF3LhAZY+CAL2gl6aJIaJjw4zRHiycGR/djEtX81jnUIEBd+XXU
         X76sV7JcjLhB6k6VGT7xJ8y2QULdaXc08eMKDMg2iR92P1RLfcsymRsipPtzrGqN3BDe
         eQDbabpdSUMJnZA3uKUMhzdt74GxHtA5g4GCb110zdRn8KgkYGskGEF5ywWfOf3ix3/9
         WMIw==
X-Forwarded-Encrypted: i=1; AKwUvBzSgv14Z50UhIWqTtOdUa0u6fpu7BCNrcWBLfQ0FBvnSPpOMDU51Ires0GFdOqq/TwtVu1Xp6U=@vger.kernel.org
X-Gm-Message-State: AFuF++nips2c1CzI6Do70Odcnf79iTssm203irBANyveG2Nbl24goCAp
	CUzf1d7S1OK3MFmyn53HuajNMh9j2TNVQVpl3IfsKTYdpZghpKscGtgh
X-Gm-Gg: AYBFou1nqssDb9StmdHGcL1ytMvolt54pRfrWKQ+WAAI7ye6HRdKSIy6m9+6+yfxrzz
	GWcxFsvF3g3QAgQaSYx+9Y4Y0GSu+p2xMa4Bi04wJeImw1zRpS5MfPcEm4A9FMNOUeaa7GefKjA
	ynPHmQz0rUNYSjRyXfcu2VTM+SsGttiwc2mDZvGwWPYkJg298zo5ya4aUPYUEqQw/SvJV1wfr6V
	mYQcTK1aT9Tj3dnVoPPbTfLCPyapI7lbVM3GMn6DJ7k558cnMHQIW3EkM56YGLN0Ae1sVU52x30
	fhmkbR1FBgsK4U50vtamdqZmBrzESjL8rF/awqN907fCQDML8EHKrJvdznk4UCJnF3N+gc/QKv1
	qutJ85deVCRUlAoUzM6wAvnzuvTzpVsAH9iGdhx8BSSjXE2wtNtXeVuw64/cL7zV0qHuhlVtyUM
	eUJvfwn864/qDQ3DJjyHkBuzmW7TAJeskRNL/4+mECZk75TiXV3yO7/bs+nNA2+rmswKXA1TXXD
	kbGgsUMSwoH1ES/MYf9vDYUe3jcpcYtqGkh++V76PikYq+35OoJp1+eKTPveCwH02eggxCB/HS5
	UqU2ohK3S6aHcppvkEfxnM8OXkeufu0pzqCc/4yB7Yp95e6oWCpws1yZE59GUyusiyqK37qHFMG
	xIi2oAomixEw=
X-Received: by 2002:a05:600c:3492:b0:49c:fa21:1c8c with SMTP id 5b1f17b1804b1-49e6cc233aemr12337045e9.33.1789196111526;
        Fri, 11 Sep 2026 23:55:11 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6576122bsm145786115e9.2.2026.09.11.23.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 23:55:11 -0700 (PDT)
Date: Sat, 12 Sep 2026 08:55:08 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Linus Walleij <linusw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dma-mapping: flush FROM_DEVICE buffers on
 legacy backends
Message-ID: <aqT2kBGIQJLWEqkf@gmail.com>
References: <20260910063620.17768-1-kmehltretter@gmail.com>
 <20260910063620.17768-3-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910063620.17768-3-kmehltretter@gmail.com>

On Thu, Sep 10, 2026 at 08:36:20AM +0100, Karl Mehltretter wrote:
> The legacy write-back cache backends invalidate DMA_FROM_DEVICE buffers
> when ownership passes to the device. A plain invalidate can discard dirty
> CPU cache lines. If the device writes only part of the buffer, untouched
> bytes can expose memory contents older than those present at the handoff.

Sashiko flagged unused *_dma_inv_range helpers in its dashboard review
of this patch [1].

I can remove the unused invalidate helpers in a separate cleanup patch in
v2.

[1] https://sashiko.dev/#/patchset/20260910063620.17768-1-kmehltretter@gmail.com

Thanks,
Karl
