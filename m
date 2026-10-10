Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124723BD17
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599775; cv=none; b=r5C+dKJ33mvA5ojNpVo3K4tSLbWQBM9z2pXBm/cE+ggzE4eLhINUtcEtebAaE6ccYSjOO/8tPPexiMy75vRcSADZlGjPxkyrO/ofsmKW6RBsRdGp+WlG7gsYl7fGNAQ+bXQNr/7Fzzo+QdRvGR/fw8oiKuYV2Eui7rrNdRby/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599775; c=relaxed/simple;
	bh=A51dYTmNQlNEG+5tR9Chhzl/dZtyn2HsRPAvD5n3sSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qc3DomsZJv5cJTAJdwIpjnlZkKgrmoOTg0dVJpqcB0q1P1zXBkEU2UqzK7xQ2XYjCkn5vanqSNd86Xw82UrFZhfBye4XVsLz0hnJDfhu8GYJiklnFYXQux4A4/mpxEHzfKyvCbF2dulz5XhfGLlccWJ1OtSr2rYqCGRBAtwh3e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCRSJULr; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCRSJULr"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-356b1e20700so627520eec.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 19:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791599774; x=1792204574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A51dYTmNQlNEG+5tR9Chhzl/dZtyn2HsRPAvD5n3sSg=;
        b=LCRSJULrMi9wu6/NT7fiv2IMPYVbCGeuE5U2OvmkzshOBnpRQNCiauOWtqSAiEZjwD
         oQpaz9vqueZJlis7t1gLFQMQhDG8znaNQqSzSbmM5snU1sgYQIHbchPvxDDFOUPKdw5t
         kv14e4Q+OYBTjzcbF6vXGUnkhsEU3lJR6kXarQPR1Os/tNwoTM3EqzZ0iXOJ+UrXpqLS
         hEPOEuVCPONeh0Quli1zjSchhL3Z0suma9+zdXT97/zwEY7jKDKmNwhR64fttrRZEUQ8
         u62/5ckNC2z47UrHaa2rWHQqoZwGW4B453rIvZHChya/0ycSzCEIRqV3K3YKNCs696kZ
         e5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599774; x=1792204574;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A51dYTmNQlNEG+5tR9Chhzl/dZtyn2HsRPAvD5n3sSg=;
        b=I5rwD4+YJsEx+JOqt5npW9/ar4ByutopXoHpgVWVfoxJMytg7bRM5yF9pgCfjRxDcr
         knWRd5EdQ3r5cLHmyzoQ5DGIMknurAZU+B0iM4+KKnAM9YVrHlNG5wIJGA9WJAQai/h+
         JNbyAe6FD2en3iu7mCFWI2K9arVLaIVsJwn9wDZfvQWy0fhw0ivM3OR+y3kOsuYmrCGt
         cEyLIqYREpItYXTlFwYfOomB4MMoZ2uRnSfhniUkDo5zKYQQWXA+pJTg9XAhNr0KB2kJ
         nwzp91vbJEtmEDV6L4f6HGm+hgCyhHRHKwe/Q46kWPxQG0ZFjMi0cDDTp9MotcBKZg/P
         COXg==
X-Forwarded-Encrypted: i=1; AKwUvBySN9ckagDJmMdB4h4nr2VPF080Az8fS/YSzrTVtSDmcpEE+6dpcbvraLaomOmnd2W1AldkFpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIoEjh60mBqNocpMxGdJ9PjcxBaQqByXe5kMKcEK9v51ndbacXK
	l0Dws0jDnQP33FGhn2cPMgglVYI/ohCh8DOuP5nIxfwjCv1ab/14LN2m
X-Gm-Gg: AYBFou2CEd572tvVzClnGVIBCLrwpBNDhBHMZykZcWeyufeFbMIPs78UAvJtSoFJxl7
	jMsBOuS45k/RQLgYDLTZY1qxY2w300lIe2WVMyoFe+t3Xrrww4vY1W1xgaYUKlGT1XSRihVkVOG
	3Ups5Cb7XdvKpJpHt+W8xl2tYrAjAhdAojNYSIYBkWTrkoa41zWsuStTvFbRhnEQahZmmDxxl1m
	L8poyWnjPxfFoNcVxy+vIkVOHQ2ihpeQnS02I+wE9HV40WWDmyhDpfwdXbYFFUWKn+ijuTDTAii
	YppzmsA2V17V02qirMBh5R9mf6iGsjVno2USHEzpkAZLL1ulS9RcHg+5i5zdyXWrYM+mC/kDgPt
	LqUDdQGC9D27LCTpf+jAzsQpvGMuVSkqX+fheAl6hHUvrPdXMlYKGDcLBTzsJa2zXjM7KJqjD2G
	TtUzMk3nAa9e6ocWcefyMJESfNeSp3E8PVLsv4cGDUIO5E3jEgGbFr/vgcf7Wn/w==
X-Received: by 2002:a05:701b:240e:b0:166:f097:6f10 with SMTP id a92af1059eb24-16a1206facdmr4452008c88.11.1791599773725;
        Fri, 09 Oct 2026 19:36:13 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm12850045c88.16.2026.10.09.19.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:36:13 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] block: don't quiesce the queue when setting the default elevator
Date: Sat, 10 Oct 2026 10:36:07 +0800
Message-ID: <20261010023608.3667184-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
References: <20261001-bug-block-elevator-init-quiesce-v1-1-5c85fa0ec59b@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ming, Jens,

Gentle ping. Since 1e44bedbc921 ("block: unifying elevator change"),
setting the default elevator quiesces the queue again, which
245a489e81e1 had avoided, so every disk added with a default elevator
waits for an RCU grace period. START_DEV of a single-queue ublk device
takes 7.74ms at p50 instead of 0.68ms.

Ming, as the author of 1e44bedbc921, could you take a look when you
have a moment?

Thanks,
Qiliang
