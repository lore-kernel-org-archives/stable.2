Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A13D9DA9
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696162; cv=none; b=csdXTPCplolzCUs9jIIv69EZmBvOdyhXl47npKB8cH8t0KzX0vwu4o0SIX5nfvelaG7l/mKYEzrC2IVQffdVywuUWqWP8wqZjnCm7uJgg8DaKPoQEQGx1M+gp+8sH5AkCVzGRoZolizGpDXuls6kvxCP76LK3NAUbqk9eYBudPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696162; c=relaxed/simple;
	bh=bxffyEpnLVkP4UoXGAqp9nzrCDo4X4Z5Z1f+WmrnipM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ampsUQX9QEs9Wnc+kZrS4qKM7clbtUD1VwZ54MJ14CKxjp2d+bqDuuLWBcV5axi8DEHvrcJTAMSBca21yZlSHUKK1f6cQ1vDKFvdnBXnUUmqh5feMxxCMn5mgD7/HziNPGpxpLoTJrH/SMeaemUks6TWLMLtylbFEYSHtq+6+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech; spf=pass smtp.mailfrom=lolli.tech; dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b=v+mn6VDc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=q54qOC7b; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lolli.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lolli.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lolli.tech header.i=@lolli.tech header.b="v+mn6VDc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="q54qOC7b"
DKIM-Signature: a=rsa-sha256; b=v+mn6VDcEhxYhGuU0sLVevUZocGu0UMNp50Rk7bMDkbqzTuDdl8MhC9SChaDz4UIykq4V/+ca2BJBJGooYBK/twbjSS+RPrkEClCbiR9zP+9FyfRwiAkn2mVUCsNliZ3++V9t+43IvYyKexNf+PeEc7Eha7qvXT0cAC4t5QbZCRbkeadlCrnFUBhSRxbR0WWat3f3GVj2BUWqZvV05/vGZRgDtTeyB62iFklQKu+v/feu/l9vabkD8MTjjKHEUm67jnhDPMyXP5rxhxQj2Fk65sSnprBzR4JBzfFAi8lRoYQKChYEmnZAySdeko2CD4lI3/1m1Q7kJzjGD+fG++uHQ==; s=purelymail3; d=lolli.tech; v=1; bh=bxffyEpnLVkP4UoXGAqp9nzrCDo4X4Z5Z1f+WmrnipM=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=q54qOC7bYmchrl0Orlo2Iw+tiJWuMPI3ZUafhQBzfz8538Nbs5Gk+CePnySI4kpm+EZDxnu4XAjwKo2yg+5HK0pvs+bc3QQtRCZBWW1i8aUDS6zbZb5KQ+Za3r6PCzzMOs7U6G8+Sd15/cm1yJtKe/FQKnRMjZ7tg/KjP4+Qo1nI+MgyV/nyIUXx1/kUoEzt4uNsP5C2o335GAOSyZBRR3LB/3knX0oGKBQoHCb8/zD2xGofZQOXcZWcfPAShCArzYKYVhSDUo5gyoW+7IBGiRCECW66PLuODNtjfPWuKHTnKo6CYmjs/wMzL6D/DwYLEkszk4SLQcHWHcu9x7Hi8A==; s=purelymail3; d=purelymail.com; v=1; bh=bxffyEpnLVkP4UoXGAqp9nzrCDo4X4Z5Z1f+WmrnipM=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1437734:55302:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -366992126;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 29 Sep 2026 15:35:44 +0000 (UTC)
From: lollipopkit <a@lolli.tech>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Richard Cochran <richardcochran@gmail.com>,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] io_uring/cmd_net: drop unextractable TX_TIMESTAMP skbs
 instead of requeueing
Date: Tue, 29 Sep 2026 23:35:28 +0800
Message-ID: <20260929153426.90278d054c98-a@lolli.tech>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <willemdebruijn.kernel.570e0a646f4@gmail.com>
References: <20260929045433.59435-1-a@lolli.tech>
 <willemdebruijn.kernel.570e0a646f4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On Tue, 29 Sep 2026 11:06:26 -0400, Willem de Bruijn wrote:
> lollipopkit wrote:
>> Assisted-by: Claude:claude-opus-5-5
>> Signed-off-by: lollipopkit <a@lolli.tech>
>
> Is this a real name?
>
> https://docs.kernel.org/process/submitting-patches.html#sign-your-work-th=
e-developer-s-certificate-of-origin
>
> "a known identity (sorry, no anonymous contributions.)"

It is not my legal name. It is the handle I have used publicly for
years, including on GitHub (https://github.com/lollipopkit), and it is
the identity I sign all my kernel work with. My understanding is that
this is what d4563201f33a ("Documentation: simplify and clarify DCO
contribution example language") intended by "known identity".
The earlier CQ-full fix (3a3d93070c5e) went in under the same name.

If that is not sufficient for this tree, let me know what you need.
