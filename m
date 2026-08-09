Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81413BC69D
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268614; cv=none; b=fy8FF67/C9gSP/ktOQxjNs0P97nuX/x1moxFwcyAsmMGZFDiL0elhejVmEv6nS60BUVXHnNdkSntOFXOP32NE5mbf/+l+irfbl1spuCV1GX4KmWIrGTW/eaUddUoYsInvDv48LShAA/fyZTBU3cOJ6hG197be2DvU1Uhml6S8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268614; c=relaxed/simple;
	bh=xeQcq1NhioUmZtroV3ZJ/+YDFjoPioowMrw3mFVa7iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxInvLFB5paqitvfv8ABck03ydwL7pbHxYTbgTTN0X/MgGSuW5UxTvDmYrVkORfJGQiLm+q5C7chB4CNDyylQA/LUvHla9gFNic1cwubj+F3uIl9Gotu/e5kHSWVqqvswWehqM3xivpw2sxnyWlDjaHQXdRK6BKRjeJMRQLbBv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDA9UcyT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDA9UcyT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so10073665ad.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268612; x=1786873412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ih9LpakF+mpkCHb3f5Zwg7Iq6/NHHXiKT9FHsKLCHD4=;
        b=CDA9UcyTWehoxiHMSbBgQB4cXR6xFpX3kK8zgLAYdzMqmMGDAOp3fqOe6KiKPeLgLG
         hHmSEp26L74YalXi1PPjkfRF5t18DXFiD/sOhc89c11YmTl3uaOnGktvuXAacdD+y2us
         hWWsOXKuAKgS+x/T/ferfomdAk72Wmd+tCq0T75j3NRsLFwOa+hDkm0cuFse3RcX26Pp
         EN450PzNG7h2+R9ITHklpDYb41yUAPoD+qdkFQB73YqQraO3u0Hl8US9ByPM19Kebl5K
         +r2VMg6t2ibIeVC6WzVRXxi81QGnD9ZfgnKsMFp58PQYv/qrsS96CU3u292sHfO75LgB
         V25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268612; x=1786873412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ih9LpakF+mpkCHb3f5Zwg7Iq6/NHHXiKT9FHsKLCHD4=;
        b=emCf5pUmdDZgf2w68RggYCjCAP6xFMitOYb4LyXB+IynsnoZ5MY1B2PhXggIdpGsUm
         +VGj1tQIHbDfrj458W/c/0L0yQNWGsTnYTeOrxYwXnosPkhUsICS18jN6nOpPewwLXhf
         roqYqZzWzc/Avrz+ixsBQ+jc19/KmfCUQ9MSwdRNWwq69goS+P6615ZppaFufsuR/MrB
         lF7ElrBmleQpz8Z6zlZ/7tuTVGe8rYGdC8LOW0X3X60taBXU9T2XuLlD3VYW6HcG2WdM
         f3mj9T09MBZi2r8ktf6HM9aePAkM68rlZx5G2zQwAbhORgLpGv9tN9PJ9hQ1+aq30wyR
         E5KA==
X-Forwarded-Encrypted: i=1; AHgh+Rq463hccODGDsYgYdOHzZW3GLwd9VZmSkwt45OVdYMKyMGAjXnly3Eg8/MdJJpJTE5zhUWSP3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fGyL2wOe5hZnuDfpMWt6ONG2yeS8BzyGTl+pYydHqgYCuTqL
	Lh3SgQGfsXEltRUqBTzzdvlPEzAKSmRV09n1BuNWKVFoWvp5Un6R/GJB
X-Gm-Gg: AR+sD128v3LYwGFnlzfbimk/34oAzFjgjmghzvfbGB3pijTakfecwUSWMJTZ0VXo2Qx
	1RIFhFMPjcuLAwnHvSBzTs3o5NdqBPUZJJEd7rRrShAI5THpSCH9K344+YEj5gARhAMPsoNbh2N
	jDq/4gfNn+s7XosEuTeeUsVQWCCyrr1d2OLDagdaanjRCw65Cs9JFLrhsJWTJvjBhAn/kgYgA26
	zaTTRG3xYJXqeTRMZ2kYDC+VbRBrkeIj4Yuoyu4EInNBSfDC/nW0hQZ0fsHKYTqXrWv3OI52TNQ
	8foiQQCj0zOKEk8a1z0D9ekYlmz6XPO2S8+wCq8y+X87AjtUZojGqEyUx90difcNCK7Tp++LZY5
	MyHcpo0cTCBuJkYvHjbxC9GeYZoY1ysB73DE2jaYLce4XDBJXJ3D5CcegkAvjSOut5DFCXYyCau
	48M4huED3mtpIt1GEojgf/NUbaw5ElvVUpPEThfLK4vOOBu5iF4DnRLE8R0vu7xj+syG81ReU8
X-Received: by 2002:a17:903:2c10:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2d0ca15d0a1mr422183555ad.0.1786268612237;
        Sun, 09 Aug 2026 02:43:32 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a407esm23209675ad.62.2026.08.09.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:43:31 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	netdev@vger.kernel.org
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	David Ward <david.ward@ll.mit.edu>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
Date: Sun,  9 Aug 2026 17:43:24 +0800
Message-ID: <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809091657.879929-1-jhs@mojatatu.com>
References: <20260809091657.879929-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun,  9 Aug 2026 05:16:57 -0400, Jamal Hadi Salim wrote:
> -	if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
> +	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
>  		    sch->limit))

bfifo_enqueue() in net/sched/sch_fifo.c has the same expression, and this
patch does not touch it:

	if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
		   READ_ONCE(sch->limit)))

Same u32 backlog, same unsigned int length.  sch->limit comes from
tc_fifo_qopt.limit, a __u32 documented as "bytes for bfifo", and nothing
caps it on the way in -- both .init and .change are fifo_init(), which
stores ctl->limit directly.

The gred check is the newer of the two: it came in with a3eb95f891d6,
the commit in your Fixes tag, while the bfifo one goes back to the
initial git import, so there is no useful Fixes: tag for it.

bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c install a
bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit is
likewise documented as bytes.  Since this is heading to stable, fixing
gred alone leaves those paths unchanged.

Minor, and in the other direction: __fifo_init() does

	u32 limit = qdisc_dev(sch)->tx_queue_len;

	if (is_bfifo)
		limit *= psched_mtu(qdisc_dev(sch));

which also wraps in 32 bits, but fails safe -- the result stays below
2^32, so the limit ends up smaller than intended rather than unbounded.

Thanks,
Zhan Xusheng
