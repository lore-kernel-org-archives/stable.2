Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFF4EBAE2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451870; cv=none; b=nV8FLh7GWjSjtT6TIqYqXe91RkCLaVuKk+4+C3wYtuXoxvjY6CPSqPHMPHlqZ/ZLdgGRjfZM7JIiwIw4Ubl1mhzG208asJ5PD9nqkz5lpCF/HMjZm/vlhaN3q0rZrpb/wxg1ib41TFTGD6OCm4n6bN86yIwgjuyX6JeOIVIef1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451870; c=relaxed/simple;
	bh=oZCzF7U/pNqSGCBx7Lc2XFggzKryAdR7EYUb7XoIkuY=;
	h=From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sJiQY7hUHbBFQK3aO+d+4de5UoBrseRnZ+2wxIZglURlmfkWInZ1ErZa6f426Mkr+S2Ft+Y8FXRV+IjqlVyZ0MxOo92Mvp1+DoTbxgeZXrAc1J7GeXURqQo64V5A4ut17itzDBgVswZas8fCMwh1VK2OU3Gmo8qqtq7j6q5jvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYrQwO7Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYrQwO7Y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4995df974b3so52615e9.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451866; x=1789056666; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oZCzF7U/pNqSGCBx7Lc2XFggzKryAdR7EYUb7XoIkuY=;
        b=CYrQwO7YRxSLIGtdoSpREAm7iPBHFgW0/rW/+b0MgADVl61csPLfOWE+W2wRwBLR6v
         ted+Ev4szN2BlL7fQPcS60ZWYgRnidYnViDpQJW1mzVgVsVTEG4H0mhhwtzGoLVeSyj3
         qIGtqzFOToMPXGSzVOlbU6RhgY75tTrG6UvB6U3kG40f9ho2M/1eZHZCV7gjY8NwD3oI
         AMiY1Bkm3r+ICLqS19pQXZn1WA7krrjQLn26uRk9c1QhBHUb06CrKiegXqzwgZx04Iux
         kPov6gpUrOTNK0q5osgcJwDcMjQb0QLSvOLbI0v8VHpSyG94NS3OHcQ/RINveIfYrmkh
         H9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451866; x=1789056666;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oZCzF7U/pNqSGCBx7Lc2XFggzKryAdR7EYUb7XoIkuY=;
        b=RExnrY8mdh98LtF6LAMuFH4vCXXPC4y/9VOBZRoTkcFu6463reBky9ws+HN97VqEGQ
         yjGYF+AukM8qwBYMK4rLkvo+DbzATt0G1eQAefDKU/sKKw9HwiQLpA6X6NTCDqIVSPe5
         KgIHQKqj9QTLlvcCjRRlUctNSb5gqJUY+KcwzuNM7Wj1iSUMYQDBYZcgzkv3M6sZiwNu
         juzkURO+ogEm/8ZmqoWdRnmOjSVvoXi1kQUXE/vxZenNksXCxdmVxBmDhT7SAXguwuX1
         gkmTUKiAPpTVYoCisiITHEEpWB6CKEW8lP3FrlU/14b2GdSv3KzoGyPiwTy/RLaU51b8
         G1Ew==
X-Gm-Message-State: AFuF++lu5HVstWiEJL/KJ+SfTKipo07CKxNPcAocxdnH3T9DfvVbMLKi
	94mSX/2vfc2+xmhbp5SE+dFdWXlXb5f3tshfuhMpKiVbGHqlNPh2hUCJCbxf8sWMk5A=
X-Gm-Gg: AYBFou2neeqxZcWnI4q++38MjkWzAEbw6S+MkRc6OBTUC2QM77NVdWlE7rTY66jd4Ou
	+Y7SOCIWm4Vt0UFL/CjcPU2/lbrmizsM1OE137xpkAVJk7SShXGMebNL3zPSkxcGViLRTUQ55/W
	SA0w1epHfxnLV7r+dvSqPpCHQuZLZh0GBtQWYW7rZCgUBSp9z4ocU1EADYy3LV4MJPH1CljhT22
	S7pPjs393fhxyH22aPqLxCiai6CcclpbSHeub9+WySsCKeJwW2kbh5eBBGbsZmsFl2J7ejzNNTj
	+lPSV4iifK+xl6+q7oRcnyE/ha8GF0pMS7O/5yOII88TCVkz86ESHnw+RdtShmUPc3+neqy+njH
	1CUoEWTkey1CQJ+2d/DSwhfqOawegZSSPxkmobge47zPKLHabZ091RGK0jIh5O3RqDUF2GArG01
	Z+5+XT40izmOOs5THDUiiJipL3179ApnLs/NONTOxqcBl/DMqrRbSs2AOS+d1mTaT5hQh29+056
	+0IxFP8aqqU5LJejEhwSGYvn5UXaPxyrHXkEYTPLJKnX7he/kUPiOemhYvp/83g5NblhRv/E4zb
	pUQaPKyHdWeguiDko1sREdo=
X-Received: by 2002:a05:600c:530c:b0:499:cef6:104c with SMTP id 5b1f17b1804b1-49ce58369f4mr111926625e9.1.1788451866233;
        Thu, 03 Sep 2026 09:11:06 -0700 (PDT)
Received: from [192.168.1.144] (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf2abe1basm49686565e9.10.2026.09.03.09.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:11:05 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: pvmohammedanees2003@gmail.com, akpm@linux-foundation.org,
 joseph.qi@linux.alibaba.com, mark@fasheh.com, jlbec@evilplan.org,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 18:11:04 +0200
Message-ID: <178845186455.1865019.8043691693828475058@gmail.com>
Subject: Re: [PATCH 6.1.y] ocfs2: fix deadlock in ocfs2_get_system_file_inode
In-Reply-To: <20260903152421.1801322-1-miguelgarciaroman8@gmail.com>
References: <20260903152421.1801322-1-miguelgarciaroman8@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Please drop this patch. This branch already contains e79c0fc4f61e, a backport=
 of upstream f5b1910e23f1 that removes system_file_mutex and fixes the lock i=
nversion. The older trylock change is unnecessary and can cause failed direct=
ory lookups. Sorry for the noise.
