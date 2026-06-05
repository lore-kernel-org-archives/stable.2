Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA133DEC2
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687679; cv=none; b=WLQo3SQi8K2gjaU8AivKCYf89Ts8seQHxQxuBuOLSYvue1dji79FsGfqqpCADMIV2foD/wgt89UviTXXsuYUcPDb/rLaMeBe7HOM7cW2eGNmKZ+xupZoVRmYi0mrMIkNTBoIwnYHfak8dP97iTn8FzP1NEsWSoJFDG6nX2AdeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687679; c=relaxed/simple;
	bh=1f9vhyvrCdjommO8e+Pf2/I63QM9ENxWmHFXdNcb+3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsuQAVohvkRYRu8CePvrX23IhGVr5W3O3PxIcxDjpuDOaRFBPuMug6l2r3Wv20c+FJCnri6azAe+EDQk2MhVEawipzY1yexZSO0e0bxvjZpRlt49B3srx+a5Y5ezlu4M99JR/UzsmWD85FFBgOluX0iVyuwfD+B3tLGEw+gjJu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQlIarQP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQlIarQP"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8421f0e9c5bso1071816b3a.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780687675; x=1781292475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IBG9rdlQryA3/YVME2f5LNj0hfA5RYuHNzIVbO8zBg=;
        b=lQlIarQPkRLLMGClfyqjb9cXCWv/XwSqOKZLTzXJNfw31cX7hmyNIL6sgXoDzJpOLt
         HJXIURnHNEAhyHaITNw6xDyM0f3VJw0ggsO6XJjHV1ra9EnNJmq3EaQqnv4GVENa6ncZ
         h6pcm0AZrO79kpoyW5di9NrJyMdEqLjMLOemlrzezHwwQBfLhLn9DhDwm1uu6XJ0d9MA
         ZZfjJb6vzqXxgjg8QBflm+9hSO0C8+91foBGiThN926+VzRd/FJrhkIJnVGKEPbIK26E
         kIqFLT28VR9hTwo3Lgp+Ua0HKiFckhpxhW0hiwywQImUIi4zn4yq7oPnP2xf0LCTuJEd
         Cafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687675; x=1781292475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+IBG9rdlQryA3/YVME2f5LNj0hfA5RYuHNzIVbO8zBg=;
        b=dxhjr04kYT4hz8CBbEiUXKhePACZZFE79qddr/Oh1dKo4DUJxqfq/LvPO/THnEmbUN
         P5o+w5Bn3q1avk8ONZzIsUMhTh6kX9DHIFCK9mOGpQ67WltZ5Zf+qv6E8gpT6UahW0Vc
         duVTmvbmBUCkAde8hNsTI9+OZu1gWdZFZFUh/3uu7sDCwCFnHWNtF3dDR6hw2G7IBMY4
         GJrK0FL4OWAwBETF0SpjLn7P+RzDNCBfjZWmB2y6ndbu7wm+Qq1gxh8EkuWdAIlL25XB
         P7EuFmg3tk7MR+xnUpHLwIZcJbHMgOEvKfQ/CLMHtzCs+vRgRYREPZyfuoAD82KftLvr
         uirg==
X-Forwarded-Encrypted: i=1; AFNElJ/1dtSWQpmS0ZTuK9AM9/4XPaKqwymN4h1A2MKed+2usAYUbIMZ6cRv6TFxbDh14UDu3iFPdiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2rxcbE4wlfkPZ7O4DRDU7XDgbrtGOBZMi/yHdzHzFctDAPEi
	nsRQ9Bcl4xAhZ6fZ1oCMBKUkBy0OzXraEdtGqUEyOtErQUDq6TFxrMrMUQZ6WA==
X-Gm-Gg: Acq92OH+xTYc5TDa1uvqaLrsEW9OLLIXXM47FTbqMzZvpP/FpyBYM5aXxIo0s/LI+KY
	0i6tfnIIvutyz7wSmOK8+6QR4SFTqEq5WlIItdA3jgXWX5yPbWchTf03h5Hd6vYnF6AR/F6CAhl
	pATdlqbN6TUKosnRaIky9IHPulUN2nd2pXx8HCxTdH1RgD044F8iKHcBX4wsDmoSU3kDFv4/ugb
	lZI34NyYpwPiiq929vY16/nyQJ0E6EUsHlGR51xP+i5RFxKY0Ljv58KYkpJmQSqzDV4JWeD02/l
	nHVWty+PYozi37nlnwu0sxneI8ioxKhf2vko/KuG1POqscNI0PY42vfoLu3nhNsCrgEjndbdKor
	aWwaVjc7/9LP+C2MKkkaX6s3giM426nrkZu+6C6nWE6o2+eQ1cM4jTHlXYD9urB3imKCLqEtivL
	pLI+DQebXY4AWaWpNIf03+qthXIvcc
X-Received: by 2002:a05:6a00:cce:b0:842:2f3d:dff2 with SMTP id d2e1a72fcca58-842b0fb53admr4887192b3a.34.1780687674695;
        Fri, 05 Jun 2026 12:27:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282221671sm10829933b3a.4.2026.06.05.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 12:27:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	fuse-devel@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] fuse: fix EFAULT clobber in fuse_uring_commit
Date: Fri,  5 Jun 2026 12:27:06 -0700
Message-ID: <20260605192708.141921-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605192708.141921-1-joannelkoong@gmail.com>
References: <20260605192708.141921-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <clm@meta.com>

copy_from_user() returns the number of bytes not copied as an unsigned
residual on failure (1..sizeof(struct fuse_out_header)). fuse_uring_commit
stores that residual in ssize_t err, sets req->out.h.error to -EFAULT,
then jumps to out: with err still holding the positive residual.

    err = copy_from_user(&req->out.h, &ent->headers->in_out,
                         sizeof(req->out.h));
    if (err) {
        req->out.h.error = -EFAULT;
        goto out;          /* err is the positive residual */
    }
    ...
    out:
        fuse_uring_req_end(ent, req, err);

fuse_uring_req_end() then runs

    if (error)
        req->out.h.error = error;

which overwrites the just-assigned -EFAULT with the positive residual.
FUSE callers such as fuse_simple_request() test err < 0 to detect
failure, so the positive value is interpreted as success and the
caller proceeds with an uninitialised or partial req->out.args.

Fix by assigning err = -EFAULT in the failure branch before jumping
to out, so fuse_uring_req_end() receives a negative errno and sets
req->out.h.error to -EFAULT.

Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/fuse/dev_uring.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e467b23e6895..e33847436693 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -811,14 +811,11 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
-	ssize_t err = 0;
+	ssize_t err = -EFAULT;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
-	if (err) {
-		req->out.h.error = -EFAULT;
+	if (copy_from_user(&req->out.h, &ent->headers->in_out,
+			   sizeof(req->out.h)))
 		goto out;
-	}
 
 	err = fuse_uring_out_header_has_err(&req->out.h, req);
 	if (err) {
-- 
2.52.0

