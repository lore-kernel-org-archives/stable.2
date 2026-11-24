Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527002;
	b=HRQ1xmneR5iIenwjH5L9qKcavR9xZaTY3VRfSIwmJil23cKsAoSFHhI850FoM5cLEpzb
	 kU525QLxeb/FvFXNyrdXk5cfP5VbvLKMRvaM2hBZROcW9ClQbCJmWyLH4UvknJ6b7YzKz
	 qsiDmwIFZCB3oFDUT2wmN7mtScN+XAqI4h8/2Q1Vx7/9D6TVskB4ft2ayvbsCeE+6vo5A
	 SO0V+PUXxbgY95WIHcL/eozgCuWRcnHaUeuoCziQZPH6KfutXSuxWO7o4AdskwgOKFhr9
	 5OzwpvXPDHlhgBsWkWAOfZX9G1sn1lANo6WSxejQvci15yu4JhWkpVAQwTZfZZWAgyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527002;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
	b=z6ofB8QdzNDxRX3smc01fOOB64+/DWEAFwbokOR+Ziax4/MHeYKgP8tkusg1fDja46db
	 ba2ia6oqh1bwLP0HjBk9HyXtDVcpnkACsDJugQ3SF4Yo2+to17RGKKKEPz7zrlW7Dp5iz
	 lgQ0G15MRs9S8iZFk9yJ1Fw1MxgSl9oMcspDx3oMt5mvOOufLdQB/zAZvnJZ/3IfUmwOU
	 rcZ9jC6s18toAn922OXs57xrpOKdQg3lalDH2eWtLZunRdyuIwa8rfsvFO8p6eQZfSndf
	 NpDYT1GopGdKN1chUlZdVuzae/DyTyTmUatISbX5jfFYKxeJDtyZ6ra8u7Pio9cXGfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="A/w2BtsE";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NIDesLzg;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3A606A330
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE3A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/w2BtsE;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NIDesLzg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795527000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
	b=A/w2BtsEyuK3/cBGzkK7wF9u/CHEP4OT3E+uUmft1q4TbhREGt+zUeYk+8fMApVfN90vzr
	4ZVP7/S2s3OF2Bulc5K2xL70HBqrGVXxM7pFHtzRjAvrYIBbHjvKBH8mXGnaPHlQdZvv2H
	aNVLSEfDri9RhgpQ+Aspc+gAoZ4DyLY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-1AE9AqRkNNmwcGMnL4pUIQ-1; Tue, 24 Nov 2026 13:29:56 +0000
X-MC-Unique: 1AE9AqRkNNmwcGMnL4pUIQ-1
X-Mimecast-MFC-AGG-ID: 1AE9AqRkNNmwcGMnL4pUIQ_1795526996
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d322fbso654956485a.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 05:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795526996; x=1796131796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
        b=NIDesLzgePeW1RI0l9jKnJHf2IhnwUfrUG2lBF5y+GZLhZ8Z3Ie7UpBf6SP23F4iYV
         x2qvOckOntfNSX1HuCJ0VQoFYumN6u7TV8xuc40J42HiLZk/fq1i9FTtDmjBd2oau2LY
         PGHK8eItVm68NPPY+LdgsqeEgv2Sb4wQ7am7tALLiq3Bfjsg72hnAkEsD7NvRKDAGQa9
         A6WVvroMc+D7Tjo741ZXl4KdViQW8l3aAOD2YfJlq7hT1RbgByrpYDzs9hi0tUD7AJnO
         OqN4vluVGic+u3umCBsMQ2KT+1vD3Wgpd1xXw43e9B0EFg85cQ0i1uewBw4wW2w9EvFB
         tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526996; x=1796131796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HbHpUlOb1f43/quJqropjm+88ksUSksI9CVMWl4Gkh0=;
        b=eK1wEwor3cTs8Gd56pdOngDaIo76fpuwf37YrNvmeYSrWm0xxpmjK/lUI9DEOoyJQ+
         4Wf7fDc9TXhZDOliJp3xcW5wxRrhSzJy39NFMe8SlEsYvDCmr6dSBjM6OrljILY7WPaX
         xihVBgGeGuR7kVG8TkBFZHajEKzOyo9Ln5iLIu2AOJpT5CYWbU+ZrTthCFwBon/cDFsY
         oYFMzM//HuBffUZpiOxOqL/vCpAYQ3uLTcAZO+NR83QiCm0vC8tOVbDWFfhx6O9I2u9g
         l9pT2H4EsUvxasNEmt3IQJtnne4s1Qr5rKgRrGcFx/bnEPvzCou6HwTNBoydyStDQrPn
         suow==
X-Forwarded-Encrypted: i=1; AL+hErHz8/tLRWIcqitGsE8rR6vVJ5+3nGEBJuz5Zaul4sTXt3fOg90Ybqeek7KWdVqNXhJqwOsSQoI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+j6aMyLhc1sBdc45Ge68wnADyhQbKsW1P46XgXL3JuNv/7WXW
	nxS254Ip6ICGiimc5BWcISd2L3NLpRxArMLjRHAV0XroMu9kukqQm5lGGb416s01ijS6IowJ3SO
	F2Ut/TRqyMxQ3oPrlbmIFD9zW87JpmXkmDUCCS/XT/wdXx35pgzm/gQBYEg==
X-Gm-Gg: AZFdTZecgrl/R4f/K84k3dJeioNoUUI20nEIrzxi81dN6ESc65Q/Y14J+DGeh2nBKMl
	jWj+rrREzXLdDEcUO8v+lmSOC6QR7oCeKJ8aVZeosBmexgfDl59hsKrYIMfjPUML9WmCBcQqEx8
	Ntaw0Q+FCJL2QCIjRq8Yqy25QlwEI1U1sr+72t+gc1j/N0qJgeTDOMXLXtg6+lsKp93HVkzNeT+
	OPrWoRkRrRu79expHMyJTW4tJLBenM/nKDGEZPkSbivRukMo5DL5FBtdNTrHCtVBrpQuAae4dDF
	RjCHK82mb3zGojhJQoopmz8433B/lMrKbSNFUTEOZ7GEj31C/AJ7mdt/QoUAjVL4a5vQ7rnLt2p
	ADQs2qHVsLxSZAJ/IT+LB5Iq7T+SuBAD7evBVeuZsBr669bkaBfBPrSPiYtJ56EbdqO3I5YcCK5
	Lnoh08vw+E/CScfKRezXTL2oLElwTCX7ZnJXosxjdQAAh7hwTT9JWdeaNJ5Dr/mHQ8XbkGtzeSg
	4yErgRGyJjzW8oOjzWiR11YeMkjwTd8PupHrC5poY+TGKxO4U58
X-Received: by 2002:a05:620a:4004:b0:949:7920:9d06 with SMTP id af79cd13be357-949bab0e640mr2535560885a.68.1795526995951;
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:949:7920:9d06 with SMTP id af79cd13be357-949bab0e640mr2535555885a.68.1795526995359;
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f1ee7sm1033930385a.28.2026.11.24.05.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:29:55 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Daolong Zhang <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Tue, 24 Nov 2026 13:29:52 +0000
Message-Id: <20261124132952.2186886-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1795396934.6B039543.003.4jXp835gJkz40Rf@fangwg01>
References: <20261122193828.1324376-1-amarkuze@redhat.com> <1795396934.6B039543.003.4jXp835gJkz40Rf@fangwg01>
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

Hi Daolong,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

