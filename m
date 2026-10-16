Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207DF453A54
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142929; cv=pass; b=I50lJvGSdYTju0oSMMxz9qDNeAaBuudyjfD+Rcj69CZITVCbfLeWE6y5P1ydWz3e8OwqNKByGdoZvtj4nQSojIoZUo9W9AxzkcH385JS8EJi5tes7eOPPWushzyNDCSMrj04/QOeFx4nl9InlAKo8FWMYCPPfukNH8/ya07We34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142929; c=relaxed/simple;
	bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmygdeF2XO9CUSr/fPzLPN8TEgEuk6ppp+ERdlHbxg5PrkQrriAcNyjIoffGC4ZiSnyZhy2nbNMxvrEtgRgoohd2ggdzHB/MwPfkHIPzwaGiuPTZRntKyT9wE+k2coG9NepXfNSXkbHlkWRYi3CTMQzjSJ5Graal8fRqnPLIgG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWgoZFOI; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWgoZFOI"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35943f55c06so1054844eec.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:28:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792142925; cv=none;
        d=google.com; s=arc-20260327;
        b=j1mjZ42SXpbeCTVHkF6S+MNMdPUjLTvReaC08sCnxMu/xvSk/OR/ATGLPmSUNDMd2+
         hQIcwwMG7CkU5JBQO1h6bDTaOmbGSyl23CNM0cZW4EYH02tnNeAB7GQ7KlzBHddjtUnm
         3w/qYM2kbWBIQ8/bmWqaK8cC7a9SBEJWLUbVrni7j68tEZpVzLzJrGx+JlHaSVdiEisa
         F5HauXKXvQM2LEHFsR5odnj0JmeAWnuW8vnn2/HUuwyDBIRyd/N3T3kNkQB4k8DP+Myi
         9LtT9Y/LpiibN51kTX8NKCKHIxRKoguJxQztMRLVoY81JuHlDAFI+mF5qpHVu90kL+N4
         H2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        fh=arZ7xrnwmCVTmBtTTQ7BbKqe09l+Asz/2QfgpVkLwAg=;
        b=mRJKwac6kmRk5ux/+/BEnamoCoZx/BmV/aCBUuUAjwsdGR3I/ydTOo20ZjknCvVXJc
         ViyyP6b3y6+vqs5JjArlgtY+XedKyh7ui4bmYKiiXTGD9OC51xC8l1auvBO3xx4y7S1+
         1RllRI6975VLDXY8BWh6qGVIjTw747MRs/GL7j8ao1+Li0Obv7LSEdIjZM4yna5gjOaH
         +598PD7VFMV77uazkmbMwmxcAkJ3G+W9ycwNvvn81gq0mUP9naP1JJH1vg2/82aDPGLF
         62pOeuQCKtBXzvbjrYkTExXI/TLTRTyY5ji69a9ss/vtIlv3YBX0/ZySQKwz17mLTFcE
         +dug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792142925; x=1792747725; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=rWgoZFOIsGYNTdcPCqI1UBpcNgDM6iK4XabmpBNktpC+2RIL9Q7QvJ75g33Q1vmrs3
         jlVFtoKJNSGHY56MYrw0sx3B/i/tseUqVrks9CrP9RmhGyZk8vCken5WZWQdmxLu+31c
         jcXIVuowourWJLVyAMV5xNBWrHitgxM4mXmUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142925; x=1792747725;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AmKjUS0ay7JelQB3WKs+EVXewL6eQix4nu3vfmLy+oM=;
        b=K+h1l3FbbG1vNidWfTs5bumxihgzcZj62kj5ZgCNNynH4WrgwV3hyF5d9KAQ6jSOIN
         S6sX3NyLmpXZQcnBpX4A1cC99TPDQ/FxrtRAhKhlW8oehYJ+djl/l1+3jY+a2uMdfTAd
         fayTirJojK5zGx9KAtbmmhtOnh3aOiRd7cMfjfoHIM9GKk6rU84PZGHB+z+ZHkYdguPD
         tNRQ+iiLt+0HzRo77kSinL+s7a+jeQxysU3DEZ/m8EQ1wX4QRNn2YL6fdAK0VQn9gED2
         NRz/C0/5iNqRDWCq2BCAsh/BUfSQ/Je6x6j6EyY2tKMUZnwtuoBHxEHoOF2EXbHl6/h1
         4X8A==
X-Forwarded-Encrypted: i=1; AKwUvByP16xBLO5CdWHrvAy2IETcn9shp+GL67coUSYh3+gAE2RI699y0IlP8JhOTKA+ZIZvQpn72BA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBw92PjPKCAseSVkmECh5L9zsbhzQjCtz+iQ1M6wg5kzar3fea
	+Pjq3XFF9KbHaN0yYVDvWPVYCAlRYduhbfKR8EDvl6JLvrACpjo8NaRi2q6szwVmIFSdUjZuz7x
	RYMF0y/9WPnSJP+ODEaOMMeURnaS4Jmw4XrIGKOp8qQ==
X-Gm-Gg: AYBFou0HbEPPOLwp9k2bue79mdMwqE5xOubbZULVnWzJHlGV8EOTOHepMtimvP/yyyQ
	83m1mxMJcoFRSoRVqQYBtGIXWB7ahE4HBpKbxuWL+GHucXxn3Dfp32gto8jgo5OGBjbxiOBDSIu
	VKTXehh2WD8Q4OxBMLchVjbcDD9RWbp0vy3UjY1fzvAdjkYaN11KeDkOjl9mneeuWfopOoPe4uf
	v2TQJIOj1LTXQNjs7OyFtVxk1YiP4iFHP/xhl3PyZPBtIvpYjE1cdcbwq0CxcfGbyrxKrzoaE03
	rhg+DRy5/NfzCKkXSE5tZzwn8/aQVDx9LJr+YdnI3w3JojV1QnGiKNAuCFm4RLDsCEq2KORXV7m
	G6+owG+M=
X-Received: by 2002:a05:7301:6f0b:b0:353:7f47:8168 with SMTP id
 5a478bee46e88-3602e69d2a3mr3111663eec.17.1792142924976; Fri, 16 Oct 2026
 02:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922081318.321686-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260922081318.321686-1-fanwu01@zju.edu.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 11:28:32 +0200
X-Gm-Features: AclHuK96WMdSHWqen9On0_lt8gWo8BgW6QbnTyh16O2fTHfi3XWjbb_9a4MR3Lg
Message-ID: <CAJfpegseUy1_sw-ZY2XQQLY3ic9ifs+ar3GsxtyY90OASXu=yQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: gmaglione@redhat.com, vgoyal@redhat.com, stefanha@redhat.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Song Li <songl@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Sept 2026 at 10:14, Fan Wu <fanwu01@zju.edu.cn> wrote:
>
> The vring size was read after virtio_fs_find_instance() had dropped
> virtio_fs_mutex, so a concurrent virtio_fs_remove() could free the
> virtqueue first. The reference from the lookup keeps the virtio_fs
> alive, but not its virtqueues.
>
> Hold the mutex across the lookup and the read.

Applied, thanks.

Miklos
