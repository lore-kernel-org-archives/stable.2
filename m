Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793329034;
	b=xsh9SRlR3vxmEsPDWdBCAs7s+qhUbFwcyGFfYKX2GQu55dLMU3UFKxB1KcVci2M4QI28
	 WAan3STfdGqmDgNiCPGVG93o6Ag30DILvrsyU/HyYMg9afx9UtTJsacrbxFjeiu8KHqiX
	 jMKXWnAWvoGi6nZ5VKiD2GEG7RKvKVH900nIWZ0Yke+EkV4azcUb+RYUZN6EpsnnOr7ET
	 eGrF2J+iDxgIn3EYNOzHpVIBRlJrcooeZ4N/Hx8QZvdPz/mius0rKf9d5IUDuEZN4UEoH
	 fTXUM+HjvdQWL9AGtMeVfcdBC+JO8qvpDxw5fFQl9Ns9W/FaNwaKg8ldLeA39vYzcSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793329034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
	b=atEoBO2YxX5ZKcRKWNV0SMso5L8EodBzg167yYtQ3vG8nMhN9fiQ7bxU39ULSA9hDISJ
	 6/M1ZrSv/oR9J8ZnIKn4yH+aQ52XXosfok1qmkMJxKRCKM4wTEmeIngjyxu3bFthoxS2U
	 /Ir/SAgZbHcAUos2q4gKvwNLFiPjZhiOQgQF/oNHLmPQrEXJPRYukEy+3PgoCznquuBad
	 6h2PkIL8Yf0hnca10+79kXoquPEuqWLYUAzKCsGac/Am7U4OGssKHxZUOf/9P3Vw32vKs
	 S8jet2ycnosPmbupYuSfBqpJ0ZpuLTN6lDYGlmmb5vnb32xeyQXsnf3absVlfMKhgkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="mCvEF/B0";
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E34606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72E34606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mCvEF/B0
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a058315c79so75312b3a.3
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 19:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793329034; x=1793933834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
        b=mCvEF/B0x+B4fIM/iYE4URUqrgWef4VAXimGI6qerYmN+LkM2lC00w7qib/QTR9K+x
         q8EDgBKBICHnCc3FmbAcwYG/Tr24NW0beOLrPAIAuhvf6gRTt959p2G2o0ya9TgSBY4P
         lg8942Gku5CIXn5oyE0+a1T6rmsFcJR/zqf9T4MTsND/pXISxluBRn1bZemCja3/B9xB
         eEB9pOr6KeAozcL+PVhrlqO4upaRtvFRBBOnTOOABAfVJ9uB6HbdnF6mDjICro3ysOHc
         xQdeWUG1hAdFrw+eX+ckjPQrlxeE4b4fQHUjwJz/sG4pib0SoAGI8zPS9fu2RK8eZUQp
         lEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793329034; x=1793933834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/ZdXC9RaNc34pyVI5ALRxFES86jLTzutVsfPjdP/KMA=;
        b=Y0C/jO6b16GHFdMRzt1Gcop4JXtmbZrWWCHi9xjHhE/VAkyhByvj6vWYaMVCptWHl4
         er7f+JfYDSVmg1e7x7+uuBdARsu2O7BwCuSpXxM8QMKuh4kfOs32LsCdZVB3PNc6Mm6W
         /16AfL21ziILbV+we/61xEVt9ql97c0mWRo9FR9qpF0yLtvU/cA0Oc/jAGbtXP8x4pjn
         O3McadrxKcIOXhFPIjKf2JyVMIJbAMUVi8oQ9xcoe5V97sc0MiLCWXUEz4hqutf1LgKj
         8ecAjlXnyY/rzVeXScdwToieWuidZqWSXXXY+VpCNVbGHuKnPo1Cr779yARWGCMyU/gw
         hwCQ==
X-Forwarded-Encrypted: i=1; AKwUvByxBBgowd9V5M3AORFMqB3gsoiSIK23COETZOvQUpcCTFvadGTQdGIyHu1232EZ/QRTp0bZBkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ30th9SBRoOgvBATkf8hI05dnmr7u4ZP1PT3Gx5XeRcpTPNOxu
	Jy/ABRN8bzuo6gY0k2OomlSEbre7wj/jfGBhM7j5z5yZCqpKCWD5bbUQ
X-Gm-Gg: AYBFou2OH5KFQrb1TtoREd6nbPT0pBlMqlTXOynDhWO6Sty4YOcItQX5pY/9RmApGAk
	8/iDOd8EeffFHnKuoLV3CcX5uhiPVseDDyBwuJMNyPSERYMP8/VnscAg9aP+DkUxsC8/DNZZfCi
	gloBGL3TO3yckEgBYmg+RD9UPTcw08MO3q4m5viOjx81xbcVha21w5Ft23GNMjk81haOvqR2Lsp
	VeXHugpnzOWAZMIOSuHoYXfNLoZpn21mEMxA2CXKXZl5kclYSvYSy6docuMLuZWUORZxNrifBwQ
	xuNOihOMWrw1183jvBFGt0IqYILtycHwgIhPUqOjzzkIYwKZsI8imXydAIHYA6xPlTVbUGazqQB
	T+WP4mYujqEs7xBT7OIYsGrUuZJgD5y8POLqh8UA6rn5T3hmgaBEtjZXJdl8JspP/voqrOgYoZo
	dXOCZMaR0bq4Gz1NPfFsmBJGNvsDu7ui5Xmv4bu4mWfdhHl5o/STHG7FfVXGsvZQc2LI2835795
	wDa83jEok1Rcvx2E9IC3mhm+LlWQqwhH8wrQvl9ZSFbhDDkjlv5iyS4pu42MKoYaKcrqPODhH4d
	QBO5uiQTgFhZu2S399xbmidz/Ot3PJHp4b9/IZaV
X-Received: by 2002:a05:6a00:290f:b0:8a3:df84:4c14 with SMTP id d2e1a72fcca58-8a9bee525bbmr794496b3a.57.1793329033656;
        Thu, 29 Oct 2026 19:57:13 -0700 (PDT)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95cb5sm162643b3a.9.2026.10.29.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 19:57:12 -0700 (PDT)
Date: Fri, 30 Oct 2026 11:57:10 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Shengzhuo Wei <me@cherr.cc>
Cc: liubaolin <liubaolin12138@163.com>, Namjae Jeon <linkinjeon@kernel.org>,
	ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: wait for bitmap folio writeback before modifying it
Message-ID: <auQHhmnBbntRem3o@hyunchul-PC02>
References: <20261029-b4-ntfs-bitmap-writeback-wait-v1-1-e2ba711b2dbf@cherr.cc>
 <374bf856-f880-4fa2-abec-c4b2a063bf57@163.com>
 <auLlFEHMZvANXUvU@kernel>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auLlFEHMZvANXUvU@kernel>

Hi Shengzhuo,

On Thu, Oct 29, 2026 at 02:17:56PM +0800, Shengzhuo Wei wrote:
> On 2026-10-29 10:07, liubaolin wrote:
>  
> > Hi Shengzhuo,
> >    Could this deadlock during MFT bitmap
> > expansion？ntfs_mft_bitmap_extend_allocation_nolock() can recurse into MFT
> > record allocation while holding mftbmp_ni->runlist.lock.
> > 
> >   With L being that lock, could we get the following interleaving?
> > A and B are $MFT::$BITMAP folios; B is outside the cached iomap.
> > Time flows downwards.
> > 
> >   Writeback                        Bitmap expansion
> >   ---------                        ----------------
> >   lock A
> >   set PG_writeback(A)
> >   map A (take/release L)
> >   add A to wpc->wb_ctx
> >   unlock A
> >   [BIO still unsubmitted]
> >                                    take L
> >                                    extend bitmap mapping pairs
> >                                    need another extent record
> >                                    ntfs_mft_record_alloc()
> >                                      mft_bitmap_alloc_free_rec()
> >                                        lock A
> >                                        folio_wait_writeback(A)
> >                                    [wait for A's I/O, holding L]
> > 
> >   lock B
> >   set PG_writeback(B)
> >   ntfs_writeback_range(B)
> >     __ntfs_write_iomap_begin()
> >       down_write(L)
> >       [blocked on L]
> > 
> >   Cannot reach iomap_add_to_ioend()
> >   to submit A's pending BIO.        Cannot release L until
> >                                    A's writeback completes.
> > 
> >    ntfs_writeback_range() obtains the next mapping before
> > iomap_add_to_ioend() can submit the pending BIO.
> >    Would we need to submit that BIO before taking the mapping locks?
> > 
> > Thanks,
> > Baolin.
> > 
> 
> Hi Baolin,
> 
> Thanks for the analysis. I checked the paths and agree with you.
> 
> Following your suggestion, I prepared a change to submit the pending
> ioend before obtaining a new mapping in ntfs_writeback_range(), clearing
> wpc->wb_ctx even on error to avoid resubmission. I plan to make this a
> prerequisite for v2, retaining all six waits.
> 
> One concern is that submitting at mapping boundaries may reduce BIO
> aggregation, including for ordinary file writeback. The change has
> passed object builds, but has not been runtime- or performance-tested.
> 
> Does this approach look reasonable to you?

I think the early submit should be limited to $MFT:$BITMAP only.

> 
> Thanks,
> Shengzhuo

-- 
Thanks,
Hyunchul
