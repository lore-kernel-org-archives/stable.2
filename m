Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB47363C48
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788664147; cv=none; b=HmT8hB/mucnrG3iD6Svemf7d+dE8yRji47hXDrmEwUbWGZAcfGX4CT1Q58hwiJXKCyKHCwUcibrbKW6KcW9UecnIeoXFy+yuKvTG/h5K2Af+OieuVhSi+kkdhiPZDnyvtWp/nl4pU8GlB7iCaTDRvrH7wefnf9hLKX02YPsWpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788664147; c=relaxed/simple;
	bh=QDZIKV/uX3j+zK1+Z2fkOu354JoXMltv8PGuJvtlk3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBzvcmRjjTKsUIIW2MCWd5ZfgiC3G5IvaXRHwn3tSWnsfP4TWGkSaoAbSuWUDEcvUoA56G6dJPimgriNK1F2+NXWbygEFufFGEzGc7PfiDTEnZWa5EvHxEHLbzmrizENAyekDgqsN0AJoECNM7GQbhNiRU8E47hjMFVeWxWJ7kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=s+4TYbQ+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="s+4TYbQ+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38759bcd877so2370781a91.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1788664142; x=1789268942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Torks1mSNBMtW/WLb64Z3Nx0GyadSjdX4LhE+X3Ytds=;
        b=s+4TYbQ+Y6HWZI3wC+q7XXdKjseVi9/AHo7NLCZITjGqi8qmOAafmYTbThV9Vqs9JX
         qF3vqed4ivJSzoDiYw+TD824WYmGRc+f4RxpMDVr8OpVjcBwkjSLw1i4njjIeLl6H0Ls
         4qJB10n2aekD684XX6kaUPYxFK9fWgc4MXGjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788664142; x=1789268942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Torks1mSNBMtW/WLb64Z3Nx0GyadSjdX4LhE+X3Ytds=;
        b=P86iynokIvvzHy3P0pfnz8k+ieZYjVwCPqXQ3/2a4cByP+XRs0YRk6SP6ejPB/Q9wq
         wj+s5U5/tY0LR5+t+SBogTP+wboiAVGdGsCLkdsK8nzDZhY16/xjcDPqiSCIT77juOpb
         X02fAbA2dE4+eNO8pJm2GXL2Zc/7NKpw0fiFA92siQVz3P7NGPqjnE90ParLN1iSTDnI
         6baUUe/enUNscKXHfdxWaigDI6MAI3e+pWTBFjlkVZZ8KfuuR3RmeTQYALEKJ6R+slx5
         k8k5C7oabFwe0g1Ihj/8mSfdTRXgSPf71w5kHcHE4wEOAjKUdREGvU6czP2fOo+R49VE
         K04g==
X-Gm-Message-State: AFuF++muRqEA4e8PqJe4iYlEyp2PTbjOPkiVMlY+fiVymLjb6U1kKlT8
	7nx1/dtS4hqFXfjFNVczV2vlRCLmpYeIUXPOnnLpZQpSBxgevVBY0RgEVuYt3wvePV99svzEinA
	RH/nSf2k=
X-Gm-Gg: AYBFou3DtvLO3cR9JG7d9mve2nEnpAHeraGAzGRZa8DZF5PNxW8HxAz3SbZwKDJDj9w
	SvD31R7ClROK2ee+K+RAbmQdYdGPwCEspy1bhbw9dNz6i7lzocRFvBgRTOelMrWzNSnKfiCxb1f
	bEE7L8jQdoUldLf0lX2MEkRFIZ0qiSmLIqY+5R7XcO7BU1e4uni9GYPnoK5QbRU011888IsnOz9
	cm9O22y/ydmkhVfmNSQ9Ptf9cwxNqVr/qrp33aCMEHN6AZJL5DAj8A5A+oTfJgOApNsDR83U/L5
	hK4lJ6RCfubSywioyv5QU5iry3SkXLoJLmMhB219jWsVOOJMD9bwcziLyVBKteOrmRU8F+bqBaX
	e+Ne6Vqqo7egJTUV07REmedDlJ1g57XcBsaytBG/CynHF3Z3T3bflQsG8sdt9VjhgQ1RowW+v5t
	ICYtitYcrCSyJwWyUSeyx6R6E1JuzMmxJnYmMMfdcrj8SYCkCwt57c8R1NVSAr0Iv1z3ldV3mdC
	nmgLQ4xXK1+hM9nUznZCA==
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr23244037a91.24.1788664141026;
        Sat, 05 Sep 2026 20:09:01 -0700 (PDT)
Received: from ziggs ([147.46.121.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08bcc081sm18959288a91.6.2026.09.05.20.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 20:09:00 -0700 (PDT)
From: Youngjae Kwon <yjkwon0026@snu.ac.kr>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: [PATCH 6.18.y v2 1/2] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
Date: Sun,  6 Sep 2026 12:08:32 +0900
Message-ID: <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
References: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sun Jian <sun.jian.kdev@gmail.com>

[ Upstream commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e ]

fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
instead to avoid sparse "different address spaces" warnings.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
Link: https://patch.msgid.link/20260214051217.1381363-1-sun.jian.kdev@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
(cherry picked from commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e)
Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
---
 fs/notify/inotify/inotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 0d813c52ff9c..905c27e9cd38 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -573,7 +573,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 
 		/* update the inode with this new fsn_mark */
 		if (dropped || do_inode)
-			fsnotify_recalc_mask(inode->i_fsnotify_marks);
+			fsnotify_recalc_mask(fsn_mark->connector);
 
 	}
 
-- 
2.50.1

