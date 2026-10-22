Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634651;
	b=dObA6RjWbSzZBn9L3Kx1m2RmqDsb66tjNwUMjUsH5e6XzCVbgtjcqpfF+EUtEAM5KUwQ
	 fNkXXhvt6m+AFHaA7uQpIBb++LPt+q7kN6aFNOOL9oP/uAGz1BItPwDXOZXfOLhnCo5l/
	 G8VjSd0GQcM94a1DY2tRk8z41lmMq1hYuRu29PauKmBKRS2APwEVpp5t2//9PgtmiCCEk
	 zkhxhd9iD7OQ/92uC4catrUU7S6699ku+T3SlzN+hdjBKkle6S89WRqODyRaYMh88TE/q
	 LJ+5joQ5jqYKfRnzhT8HFWiCCmRYE9B3gGThGY3SFSstdbHeiiAVYb8iNihRsKxCdaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634651;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UJLSBtDKkGqZDJrYmEv3WMefki+zsrIJ6RfNfwcIxRM=;
	b=zvtNpNLC0uIh/xg4JOVsKxQagAGomo3ehYsrMwB+LDz92dQQtXh1MvaxgYnMBTe77O+3
	 aV+G3CpTp38dNui8RMihpFajEyHygSFd9zDrMDZq+xjxwgPpp5jdpUWTyoDkPSCbPIjFG
	 RZURZfBgClIhcIOT/xvt/DLunzhwDwksJhUoF/WclbNlCcMNCQAg2zjN25ARdKpZBLZNz
	 c9/2YX57MmQrK3qE3bmHvDaZ4jJd8fk8ik5jloIEdmCclXQISXD/FFp5IGOBAno9p8Ghl
	 5FE+jIO6JpWMCSX9jhW3IUoiYq+soWoheOGZ1/S6BnxRj3oQtbevLQFVHX5GIf1K4bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKHC1mpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11923606A320
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nKHC1mpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD751F000C5;
	Thu, 22 Oct 2026 02:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634650;
	bh=UJLSBtDKkGqZDJrYmEv3WMefki+zsrIJ6RfNfwcIxRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nKHC1mpzWQAs02y6Wk5rHqfdSYMNXlNGrkfuSwh0lYUWY9ob/lZ9H0QRPNLjIwkB8
	 Q9GoNGB2LD65HOJkpDQVIYXYj4jBNsdX0azGeobuTJPpGnOnhPMhdOmH++7/ahwm4X
	 ZDnZrbeg0VKYv+hObtJ51MpDFdGA6FNErTalzg/CwMxJGi/6hzGKPzp7vAyeXFYrID
	 eOvkRw9FMQCyDD5UXx28HI7zA1pLG1B45kPY8+Fdv2oGcVpHpOgwJOjzUxAF8oSUv+
	 mr/6R37aAQsslOCdJRoGif3NI6ohSGgwpF7o+acJhc7BXlOQn57jKOugSKySvxeoqS
	 ZZJvqJf/VJpiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Zhang Changzhong <zhangchangzhong@huawei.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.15.y] net/sched: cls_u32: skip hash tables in u32_bind_class()
Date: Wed, 21 Oct 2026 22:03:36 -0400
Message-ID: <2026-10-21-1-daily-reply-0011-cls-u32-bind-class-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020-cve-2026-74739-v1-1-f63ae6c92cfd@bootlin.com>
References: <20261020-cve-2026-74739-v1-1-f63ae6c92cfd@bootlin.com>
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

> u32_walk() enumerates both struct tc_u_hnode and struct tc_u_knode
> through the walker callback. u32_bind_class() unconditionally casts the

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
