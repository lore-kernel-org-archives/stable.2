Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E014746AB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838329; cv=none; b=fvUo6vuxG+nD7XXD09YqCgvI5jDUJyQjXIgof2gc0CD20007DyMiI/EKIvjrZ8p/J/7N6quZCkw2SdAaRQUvB4MpDUPDs1jBioLLIXHD46n64aXu1q+HzzKnaq11vSNmldnuqtkaUYmCrngQ2a1TgTieTyApa+gPjSdn+kgWjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838329; c=relaxed/simple;
	bh=+dI2iwCHyEnM/wK0AhPsWh7w7YUkwpqVsloo4ng0xAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxu7kwzRsp26qFN89PfhENBCF+YweJ6saxv5PfaQPy2XHPgtIuBqVNmBXa911EC9tKDr1kMprgQtZ4S3wN5lauiNDUF0a3LHWKjwjRifxVTERyo0lavVW7Bc1uIPKRuc50Y1YkUDLn9kzvIoKhsT8fehSMHgMeJk9dZ0mecg5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CF3crQb7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qPaH5D5E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CF3crQb7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qPaH5D5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787838319;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2Pe2JsSBSamTxW+jC0IgTUMPFV5cHIlg1QJSOQvf+0=;
	b=CF3crQb7/OpO9+l1sejIwET9l3126+OTV+SnDexcnZhdXQHES7TgYomr4oFMrBntMD0lhA
	CFmZl421e+oIXbinwjFY7gTsaNazGX4jb+V3MOkE+Qi8DxT6fkjJ7rvybjsIYgBNSfbUXL
	9I7ZRpZLHNIgm0m88u516eXjF6psfG4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-od01HMB5MrmPjFER7Dxoiw-1; Thu, 27 Aug 2026 09:45:18 -0400
X-MC-Unique: od01HMB5MrmPjFER7Dxoiw-1
X-Mimecast-MFC-AGG-ID: od01HMB5MrmPjFER7Dxoiw_1787838318
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52fb2a46cb5so4978471cf.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787838318; x=1788443118; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f2Pe2JsSBSamTxW+jC0IgTUMPFV5cHIlg1QJSOQvf+0=;
        b=qPaH5D5EOlXQnsjT6OHquhXSrYxfVI35qr0pZeaOzH2v9QxVOm0AgD8t6ZHaqJ0xxD
         Ypjb0kdNOR9rcafCnzxInE4+ZTujycE675YGBUTmykbcrG9YZcQlexkkEfqjJtJr33p2
         F+dkaX2/NbeDHp/mO/BOaYDEBZnMVV8MxjMLJo2yJwEfItsYVrpv/pofV47idFpOYuxk
         o3lkYfrjt2YWXeUjcn3Pn7LLjG3N+aXdmre1FUIff2tIyNOpfAqABFHD2bCL5CJA589o
         upmhuCWiGouhHtTxmEkMabTOs6yFYvS/v97Q8dqpt+iO3sAX0q02CcPOR5iqKdt3hr4l
         8/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838318; x=1788443118;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f2Pe2JsSBSamTxW+jC0IgTUMPFV5cHIlg1QJSOQvf+0=;
        b=gtaxn0WJ6aA46F8PP0vZ6OUf3ArI3GraIKjTUoC5j/FI5aDwSSCBU0k5OPKgIBDSZb
         Ety3HppOm89ESJPV3cQOKyIP9oSIqK+sBZSxwF2gY5syTDNHIcCpjsRd4MileliHFBUT
         hKg1mdn4dFdiMxzQmk0qf2mglwNFJpo9WVz62chCKE/HFdoo0LqMoavSHKZt374qsP7T
         1s9VynwtxlmI9cw1hqOCHJxyOjdo6Eh3DM0iAt0zBKjx6eTOSQkp/esfoI0cRqohAkI3
         00WIRo6L7TS/h4Yp+8sl/A7t0E1TtyK+fhFVvsF8Y1Zq70AOMKnyaNZxoPLCPdEO5TVY
         Glyw==
X-Forwarded-Encrypted: i=1; AHgh+RpxW4XfuGogSvJNuzuPDaJI2WNZ9z0r4J9bYclJS5ESt7Wckoi/uAeP4lfeT8rRlFRiQQjRoXA=@vger.kernel.org
X-Gm-Message-State: AFuF++mWhU39BeBSttRUaz2AZjAGjKOkvZh+rkrzL1FAK6D8RYyrgFLG
	1MzsBX9Hd/MUAK6/OYJCDhbEgLNRhjYOQa8wKR/A/CXwCGHjzDZqG6t8JnPweIvWyZq6H3YOmh0
	ZNkK9uogyVbSii2X2spTPWKa2iL1KOBoQ8bPOzq/Zc/F964GvkiVbwqidpw==
X-Gm-Gg: AR+sD10EFLQsDi8XY2nJR4PMOFCfvWkT9WwrYO8/B3KaIuGpzkqCzTsukKcaMcpcq7a
	vx20GFc3snvX/MSatHPWVsK+jBhGzcX4FMLNYZSz+1sbxP4gnNhj0/Jecv/TAEv2OcwSYgrR2Rw
	gAwYNJ9qc+Nvh4LdiEPc5suVAefj9vpRCxgufHPbbiF+j2dmbfUPuFhfclLHcBZlJKMLjGiFluo
	ci1bE+n0E78hogcVzVExtnNdc1ogMfha3Ac959skiUBAC7nhF46/D6Cc46EBpzzUARKml8goKrm
	JwVMB4IinXVeh3dpzVZtuecdwBU/3Ob4pcV9+sl1cbfZKpJH48mt+nYM7pX/Gm8+sA46ZfcFnoe
	oJ3ysbPM6GUd5/3Yvg7/rqm179VxgZnmfVqZx/pgt
X-Received: by 2002:ac8:7fc1:0:b0:52f:b627:6091 with SMTP id d75a77b69052e-52fb62761bcmr13206141cf.5.1787838317852;
        Thu, 27 Aug 2026 06:45:17 -0700 (PDT)
X-Received: by 2002:ac8:7fc1:0:b0:52f:b627:6091 with SMTP id d75a77b69052e-52fb62761bcmr13205291cf.5.1787838317300;
        Thu, 27 Aug 2026 06:45:17 -0700 (PDT)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52e4270a950sm36897281cf.15.2026.08.27.06.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:45:16 -0700 (PDT)
Message-ID: <8b7e30ff-fbd9-499e-b371-725c7b85a189@redhat.com>
Date: Thu, 27 Aug 2026 08:45:15 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [PATCH] smb: client: tighten validate_t2() offset bounds against
 actual buffer size
To: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org
Cc: linkinjeon@kernel.org, stable@vger.kernel.org
References: <20260825030948.3577275-1-sorenson@redhat.com>
 <f67877e37eeede299fbbe86914cd58f2@manguebit.org>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <f67877e37eeede299fbbe86914cd58f2@manguebit.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 6:03 PM, Paulo Alcantara wrote:
> Besides all these LLM-generated messages and comments, would you have a
> reproducer or a real use case that would require such changes?

I just want to apologize for going so far overboard.  I identified a
potential type of issue, and then kept expanding the scope without
finding a concrete problem or reproducer.  That's a definite
overcorrection; I tried to fix things that have no known impact in
practice ('malicious SMB1 server' is a pretty weak threat).

And as you noted, I relied too heavily on AI assistance; that's on
me.  I'll be more careful about both the scope of what I do and how
I get there.

I'll obviously withdraw this

Frank
-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat

