Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3475617DFFA
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791592519; cv=none; b=p7TN2Fqg/bGFOS05XTaD5ICiRaZARPvP/jOK9ZOBE+fLs0J82sksfr859Mws5kEhtLWzbgHEa4yAyApnFEN1HtSXM1QPOO6ECAHFDOIb6JCEt/7bvrs9OR8DOnrtMqigK8wwboT0q7Vqhx4p6Zcd1FvyVIENhCk6iozSCbz4qOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791592519; c=relaxed/simple;
	bh=IgFB88Fae52t0faG3mtsC7gchDUT3CA1h7QB8FY2kik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rc9y2zEQd067zWFtzURyiaw0wrS8yYdeysnyazne7GYmBgc4VUANaM69EzKtTTWZ8jSHpWgFhZsanLgEEgaFa9NFfuLZ7a/3GFrSmWhmSuWY8Xp9HWE5s/0ETJQ2+Pl8437Oo4KDakOi+N/xfZasFKL3+chroX3ocRNXj12voJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMpuP2lu; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMpuP2lu"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cb590dcbb1so63998137.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 17:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791592517; x=1792197317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IgFB88Fae52t0faG3mtsC7gchDUT3CA1h7QB8FY2kik=;
        b=OMpuP2luIWUXSOokqFYKskD1vtICaWgfVYyARPfzweGhptCVlmNybvwaI1CIUZam4A
         ruMit2hLONXcXt2k71vBVv9hXEaqtu/e/D41uWkp0UCse4BjPXgcBiRTBBRW7hp/24n7
         6AX2rMsrF2y6oQwLctFLsgicW/OWpeYfAvY48u0d1Jb4flgwOUaTFTnd5ybAQ6VB11el
         GpGq1trMQUoy4DgrS5/rTJMvfHkYfqWeog6wDJVYb+Q6FFmeNri4ukAjaHpRftMFLEu/
         ofylP4Kx9iKqsc8tQ4KJcgK7Xi6qyDCLdRZH9aDKFSr5Aj/Ow2GP9mOvrQl5+dvg+uJm
         MgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791592517; x=1792197317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IgFB88Fae52t0faG3mtsC7gchDUT3CA1h7QB8FY2kik=;
        b=ULn/1RSXj5axkeIZWfa8p9brE4hy4WThy3JaXwsXRP6eLR5zGajSckXrrTgKbQUy3Z
         bwOyE1a5VqB0U5YDssW8o0B0j4HpQcUE0XM+ZmapM6yrXr4TNfH1aOV/+Ki/XSRc8cTn
         yrHXc6oTcm/qD3q23xjaz+it8ZzORHMTIgmpBIuATgWzDfR6lVpYE1w5k4gQXCvafAmZ
         BxWUdekugDtBoSGOST32mFRWIXW4HonINQPHEmUKk+XaYltaIOBeiPv0o4WiE/bQ9D41
         PGyT8fRWNcMfcSPfM27JX6S7G3ku5OhcCyt5he8JH53dyafrMxyhrimk56kEX8hxfFBR
         rRHg==
X-Forwarded-Encrypted: i=1; AKwUvBzxZKmLuif3Oyb0jHbNtLEPgWOzblm0HrEA3YWid0Dkmnhq69XYe5CkjzF2SicsnWtSgMpyNF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe90u15VN+KxMg4MmWpziOM4K28tDLr41gRmSNRsLHHkT8YtaP
	TRA+xTPc39xzrR8z92lArTnSnvMPUmehOjhRju+M7POIIKQ82igCGjCr
X-Gm-Gg: AYBFou2j8fxxkyNXuFxsrDWs4Jz/PTwOvG+j4DXsvymekBYwpA8qNDN1HtFPbxULd6q
	Jxs0rnzTicgLDZdiG4OLsdy2rGRi69Jri4OFTM0OjuMUeP9UXf3giJcXfwVtLCyG7LpdL49kHJ6
	j3RcGkSGzGQzwBUgarggaWt60Hy25TraVl3yExv87uC0hqtMQQ5IEeCqXBJTXsJHD24bN2+Rdjp
	ktmASIxmgfTaoDKc8Za5hpjAQ8x1QEvkaousF8HX4DGHHAwSMECHocVDXvYvtw615e3LjksrFQd
	jAl1kr6T+S5WVckJCLj+Q+4DQAmVvtoRxcV+lgieIpfu5JDn0shTYPiLr2BnyuanurBHHTEC97T
	71xIxnLmAyLlKtaq6aA9vkPNR41ww/ndvJc6LcWXAMvH2+dtGCfr3b5uB0w2TfUq2ZcYRHVeQkW
	jsCBeS/MTPDKOYQX963dqiGbwaWq0+HhnwGZFHTXMRA1/NFGnqxFSdbGLLnTYPF+s=
X-Received: by 2002:a05:6102:a4f:b0:7c3:9059:49c2 with SMTP id ada2fe7eead31-7cb373593a5mr948439137.22.1791592516863;
        Fri, 09 Oct 2026 17:35:16 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990138f4fe2sm1209146241.6.2026.10.09.17.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 17:35:16 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ijae Kim <ae878000@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: m66592-udc: Free the IRQ before unmapping registers
Date: Fri,  9 Oct 2026 21:34:54 -0300
Message-ID: <20261010003508.2730761-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003034908.619696-1-mhun512@gmail.com>
References: <20261003034908.619696-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 02, 2026 at 11:49:08PM -0400, Myeonghun Pak wrote:
> m66592_remove() unmaps the controller registers before removing its shared
> IRQ handler. Another device on the same IRQ can invoke m66592_irq() in
> that interval, and the handler reads and writes registers even when the
> controller has no enabled interrupt pending. CONFIG_DEBUG_SHIRQ can also
> invoke the handler from free_irq() after the mapping has gone away.

Confirmed against mainline: m66592_remove() calls iounmap(m66592->reg)
before free_irq(), and m66592_irq() takes m66592->lock and does register
I/O (m66592_read()/m66592_write() of INTSTS0, INTENB0, CFIFOSEL, ...)
unconditionally. request_irq() uses IRQF_SHARED, so a co-device's
interrupt -- or CONFIG_DEBUG_SHIRQ at free_irq() time -- can run the
handler against the already-unmapped mapping.

Masking the controller's interrupt sources (INTENB0 = 0) under the lock
and freeing the IRQ before iounmap() closes the window: after free_irq()
returns the handler can no longer run, and every remaining access still
happens while the MMIO mapping and private data are valid.

Reviewed-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
