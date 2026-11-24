Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520061;
	b=Lk1AoMz0h2yv1WEaqy5qMuzXKLNUKvBLOI8TBTeePmwvqnlM925xjEwoZhvpYakvpNkX
	 5lV36AOT/JcWVl7TshNNXNLvgEcd7ZqbIBdWFQ/8Gr+Tmha5S76SbCg9dmvBVLp6gS54T
	 F9zKsqV5cLhoMYHNQ3S/1+C6MrB4m8IXdkhLBTn5yHlADnsk5nOXWLnY+1g5SnY9oKkig
	 qawhfYUuYnyYLmX659Gr5emzCBpLF5d2r3sie46DzKX4jI12U/TYl0N67yc1GJric3mQ2
	 igJTWnDSEx0W7B14hmPVE7OFPLSCiIgXO9R2Riqpw9V7FZuE0UIT4FgLapSwpfK4NIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520061;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
	b=cfWU79F/VRlztCOu9juxHnUjaQLL5EmPJn8uMe1avLK8cT2DFbU0bcLGwFaqGRo1RT5y
	 rwvqKh0+HGZG5y8hd0u/svmD7+PIXs4ZmLS2iHNwh/aLKphPZDakLqI+0I2W5IoNgR2IP
	 p0k935WnyWfJtCVR/GQCp+LyZNbmo8AamLJeW1zGDEZkBhCcojkZsO5f2ofcQ/+Apf3Np
	 ZMujBExPT/KHgCDzp3sRs/wrfFa/YLKLVnjEOLSCtCYP6/BgIKShYhASC4MBSB9SiquT3
	 aBYQsXqVq11zYEqOKgX6cFKSSH9/Mb6yiMoNCv7jltUwv9q+pNqo8xI30UdijzYSyjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CdRjt4Cd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XRkdCCuw;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6DD606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF6DD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CdRjt4Cd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XRkdCCuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795520059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
	b=CdRjt4CdmQdWlAg6g7HNKf1gLHn9OgPZAP/PIns1K/xoukXPXsL1EDBZzEIkYEHuCTX0pG
	9Ip2onwYdbqwgSPqy1Vh/TXVXkl5I25XvGZ1VV6mbkGbKen1ddALsGtU4cnOYh/dDOkw6Q
	2ExksMjLFQYD+SG/5t3qljGvjk9zxvs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-dnUaq6gHPpee01SJ3dgHOQ-1; Tue, 24 Nov 2026 11:34:17 +0000
X-MC-Unique: dnUaq6gHPpee01SJ3dgHOQ-1
X-Mimecast-MFC-AGG-ID: dnUaq6gHPpee01SJ3dgHOQ_1795520057
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9495dd0f07eso798574685a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795520057; x=1796124857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
        b=XRkdCCuw87EOb9837lr8iXSna20nBlqrT/MVq2g54ZVKvApYDUwAGeIiPhrEfdfNr3
         RU1FDILE8sjV2+5vby+0m92Ztw49gS+8N+1YjghSmIcOSCu/ut7V39UxuO7gtj/2Q37n
         KHAGb00FTSyni6sYGyukaMkUg0R/S+ZNzBXV23RdAUBlDiw8BFDaLZYAXYJtJ9rLpbL2
         4UuZcVZ6b1gn3ZtmLcto/eSQsCdfbA22yxQSiocCKwKp60JxnFPpqVa8D8AXN+Mt0t/2
         kC2Tq3o9fokFYjM1XAQ5b91o911tqe97toZbSzM1ZWNT46xHG8TzxFMPHVsnKWzt02jq
         k2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795520057; x=1796124857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m8Fzs925Xr4/4DIBabyECw/hUQw8zIv4C/h21g95nvQ=;
        b=b/lStZFcz4f3Iv50g8uxUm36CjZXiMzby8HTfOeSeH44K8qax3FZUagTgiw5mvA/Ks
         zGyO6xCUUvV7tNI+ebpX1vvLc2LGVAvasofKA3u0UJKz46MP6QCfL/0PIVjmGi2U4rv8
         LLetwS4dmifDuyKwMaUILq1JFptHyjndllVVO+m8/U9GSb6xZYRdH1uhyxVNE3Xs0ljz
         Pc3vjxKy6BYz4RYWS5VTA342adc6G2Bkc7IVya4acb+uxr1GSBF+rbGTazO0gznoN5Va
         G0JFRUMDUWBJeDnZz2n8nRiSJ9ZljO9t1AtZ0TAIkuhijwbROM3MDRzK+onAn0FcvufA
         Pndg==
X-Forwarded-Encrypted: i=1; AL+hErHWNuhhlV+gx9P/X380riulCZv6y000v+NhkBh8DBxxoyplyA32FN4mWmzSxyOJ5lty+opZECw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/sJd+GwCmxI17sex1V8Vk2bSIFUrqjYQjzKeMgJ+aBu9jDIDIJ
	nPIzDskVwNRFWuM9/WJWanhhio2UGZ6McAG9eylGqlt4i/qMUpINHmWay0XY2wSLu5lnP9qZTeb
	aNr5PZcbwm5XOxaC3Ts2MPlYqiGbzP9q6nBQ+mfrHnwATjRwUwtwPpeaOEt2ee/vbkIYy
X-Gm-Gg: AZFdTZcbNobS99GiIWNCjT9eevVxjM66RpsJQQdBJTr4JX9JxfiMMXe+WwX5aEGgnAW
	RTpMWTi7GTeQK3y5aI6TJGX+DGUjl2C+q2K0wF2EhLP/CuCTzGdSBctK2RhASz0F2pxJrZFxE+n
	w2VDHloibWiF/oYZcwiqzxmxmtw5EVw1u1TIEvjZbKoT2HKJlkh2LGXR/P0ZhPgvyv3HQP7wC0M
	GV5VVGq2NmYUjQwsVR4U/lQ7fSGvkqcYl781ZtpBfqCSR96YBbqGILZjvBG+NgP4wHctXPtKIec
	wLzRDKulLWNUyYaUSblK+Kh3uKk8/OkvesrdwPjG6Rml5/slWAxfhFfoFhTfMKPzi6oTHM4c46L
	O+KK7dsk8PJNpHn9oBbhJQQotpCQ60di1GnHdbeQ+1rau/n3tN8HIUbBPyCttW3tL1EdSu3L9gm
	0C52ozljZ0dUZbinu8t+rHxDM0iMH5rFh+fGEMfBR/GEFbg9RyzuMs72plfZqPVKHIOQoAOz5dL
	/gDTb8FU8GHmcqN7mVLL2OFLEiYE/jHfWId0O/lSNuO27HcN8WQ
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id af79cd13be357-949bab4d986mr2487712085a.73.1795520057203;
        Tue, 24 Nov 2026 03:34:17 -0800 (PST)
X-Received: by 2002:a05:620a:44c5:b0:949:a9b4:bd11 with SMTP id af79cd13be357-949bab4d986mr2487708785a.73.1795520056784;
        Tue, 24 Nov 2026 03:34:16 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb34d427sm999811385a.9.2026.11.24.03.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 03:34:16 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Kaho Jiang <kj2864@nyu.edu>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	co+408fcc361565713f@bugs.sh
Subject: Re: [PATCH v3] ceph: Use unsigned types for snapshot split counts
Date: Tue, 24 Nov 2026 11:34:12 +0000
Message-Id: <20261124113412.2078323-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261123050440.223436-2-kj2864@nyu.edu>
References: <20261123050440.223436-2-kj2864@nyu.edu>
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

Hi Kaho,

On a malformed SPLIT, the failure path calls ceph_monc_blocklist_add()
with snap_rwsem held. If the blocklist command succeeds but the subsequent
OSD map version or map does not arrive, cached snapshot lookups can remain
blocked on that lock.

After the blocklist call returns, ceph_mdsc_close_sessions() can queue a
close request and wait for it from the MDS connection worker that is
running this handler. The worker cannot send the request or process its
reply until the handler returns, so with mount_timeout=0 the wait can be
indefinite.

Please move the blocklist/map and session-close waits out of the MDS
connection worker, and avoid holding snap_rwsem while waiting. Keep the
client fenced, prevent further stale-context submissions and account for
writes already on the wire before releasing session authority; retain the
required references until the deferred cleanup finishes.

Thanks,
Alex

