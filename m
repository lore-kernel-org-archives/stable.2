Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F90451056
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626119; cv=none; b=OFpZkU7nCpDFuAs5iZFoH7IRw01H/5aDghmJQbN7bmFupAidvarCr9YfyCXSJWEi9cr1zLkOamCqLBB1/kS+fvNULlCOU5V4hcbZ5McHQlJg7LxCBveezJpT0UJG2pI26gL/GmPUD6P2oe7auThu67x4cL9y0XNepSyNdNB37Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626119; c=relaxed/simple;
	bh=xlJh76Md8wkh/Fi92cqhV/YXIDPiy9Lp3lrOEOU0ABc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RojlRiH53yWVAnkarzW6dYVUbA3G2bPp+levARHht42r0FwwkUrVZ2qKf0osKZdamNK1OQtYlvYA8xTrWunYrbPt4rMGB93Tv1olph0pUuFv0OfkT7F3FQiCnmn8KIbxwUZ+fm+83AI8RQFcmslUZK7k8XWF9Dx1yyrDnTSL1kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=S+8WAkJS; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="S+8WAkJS"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-440d9bfa309so3576892fac.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781626116; x=1782230916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzIt4F8uHY1gHbYSazgMbvRJiX7QgA75YFrjgD4jGLA=;
        b=S+8WAkJSCL9n69uYD7Pz1n2z0es32SQx6FJybPbUwamCPEcqvXdM+JXJeCFlpfNVEY
         ++ObBrFQNcE5TGDEEueZqAtbOP9tgqaCHfLOjADTu2EJ8bRWYSU09tdNGC/Axo2sblgj
         +e9m1T9hrAMicAYiN+QX1tfJa5oTGjA3seSUSWloqzUFJOMuThX8fkQLgVMjOWyAVHKq
         BAvw9dGdIlL3KLmr32HKa1YiYfqboXrwRDnovhGAWE0WWeNu9UFw8aNRuw2chg9aZdgj
         KWE49WKZttRoFIcgN6ZUc55Xmx3yBfOi+qceHCgoQB4Uop9Is7gVMKk7qwwj8544SPC/
         E7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781626116; x=1782230916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzIt4F8uHY1gHbYSazgMbvRJiX7QgA75YFrjgD4jGLA=;
        b=ePmFHil3GFP7MG5Xz3HBKEOSHOs6cPaqdhm4ab9CbkbC3iTCiY/IsV2LJxc2FpFPVj
         MqsSlwOKVUfrFqDw1u1nkJISh6IZt0U6cCL9IG8SpKGuNLmKmjHADEydtkFMV+YxvoTS
         UJK2UP1s5M93p9CUDVZypcbg7q0VuGK2Rov8mf63EW8cw4oLasBBvUyfosxjq/2mBovK
         NoGkMHYjw2HXNaFjQDIKhENGq3PGMYKBQnn0G6SISzZfBslxIQMsBRKvSIY3ADDLSt1O
         PcN7RTHeC9n0G0E9zTRPD5Whp7HVKk85BehZdnxV5vDEK+7jL1K5vsS7FCO4z4g1+SU1
         Mu7g==
X-Forwarded-Encrypted: i=1; AFNElJ+nEwFButu2T51oNVR3vsKnnrrn2fbEovLfRsL4veCfBdjBbVUryU8WqljObQ68Ar76zweHoU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSqPaz+Imb/ehIAYl9rLklV120lrQBYOad5wg9tMJ4PwMQiqq
	4o9iQ/Stbqr9zv8FRS522rrN6eLivT7j/qRVz4vOlCzkIzG7JssZlK4d0kNHR4Yj3qA=
X-Gm-Gg: Acq92OGeE/flg5jEA8ErTR5yPBq7yh5edteL4+cec8qgrrVzSunrYhAirlu004APThj
	W15w+/RqExIiTsF6sybkOzWCWMjNaCSLrKIODxLXZa86ZLoxWNpecm/20kuKWhmod/DIyJzvyaC
	Rw9Q4s0Hi6EVCAa2e7CE1fDDiNBAt4cXuMK39aBHwUxKMpGxNMKYwJahlPywDQv5TOlmenPmxj6
	OFjk5hWP94B2lN5B6aSOdzOsNImIWzFotVqxfOidVv4XXQhIgUb9gQxlN7yOnCPM/lBLIqtQzvj
	0WFX/b7XxN9PHpULFYjiRc143Biycx8Bh6wBFAgS+sbjuO3c6p3I7kLY71/lv6Zm7IdrH2XE6cU
	zy0eZ9KJ7hpv+xXFFwpxRPslD+Y/qPHXrUplOo5h4yKQJwqw5/y5MD2VC6hP0mpIq97xLpldmKY
	5cwQhofNFxUeqy9L+ItqEFYoU5k8ralufdu14NEV1Ymcng1SKr7p3fiPqHpiGOG3aDYNaBP4Rmr
	3TZyaAnFUpVrFY=
X-Received: by 2002:a05:6808:50a4:b0:486:a9d8:cddb with SMTP id 5614622812f47-48942b488d3mr229217b6e.27.1781626116373;
        Tue, 16 Jun 2026 09:08:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm4631101b6e.7.2026.06.16.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:08:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, wenxiong@linux.ibm.com
Cc: tom.leiming@gmail.com, yukuai@fygo.io, stable@vger.kernel.org, 
 wenxiong@us.ibm.com
In-Reply-To: <20260616143121.878021-1-wenxiong@linux.ibm.com>
References: <20260616143121.878021-1-wenxiong@linux.ibm.com>
Subject: Re: [PATCH V2]block: Remove redundant plug in __submit_bio()
Message-Id: <178162611541.2191657.11227673326428110022.b4-ty@b4>
Date: Tue, 16 Jun 2026 10:08:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 16 Jun 2026 10:31:21 -0400, wenxiong@linux.ibm.com wrote:
> The patch removes the automatic plug/unplug operations from __submit_bio()
> that were added to cache nsecs time when no explicit plug is used.
> 
> The plug mechanism is most effective when batching multiple I/O
> operations together. Creating a plug for every bio submission
> provides minimal benefit while adding function call overhead and
> stack usage for every I/O operation.
> 
> [...]

Applied, thanks!

[1/1] block: Remove redundant plug in __submit_bio()
      commit: 9cbbac29d752fb5d95e375fa3685a359b89caa0a

Best regards,
-- 
Jens Axboe



