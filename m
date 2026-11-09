Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239650;
	b=EnbVoU6KCxk2+SQZGbn6+A5kyoWA+HIw6K0LoLTXsl/HCqG16EyvTTvGJK1K9mYVVmOx
	 /0XJ8qihagXh4H4gt9BCy4ksWxCZHtKzNYcx3wpJJ0srGOSP1t3oMTr/9Jfh47E10UZ31
	 yh6zlu0ZDQYuv4QN/lQ4/TrNVHnfDSXJH3JjWdiC6L1gCzMvoToIsJRtuOkzr5EzZ3+d1
	 nbZ68/x7jLWHOuya6fBhBUHwa47sXLUzpuWMrdM3FdKjwPdsdN6OPt+Xupaxogox8aFzD
	 vH+4UNPUCD2/Vr9VDFS45w1e66pwiY5HMVU57NVBmlbiD9jwMneTdil4ip8fl+u11Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FxpWwF5G9wz/P+B+O2XIchuTVXbJUvEoMG6HTj+zUjQ=;
	b=O8vxhPnfIcaA7o7ySm19WQxpJm7NCG3Prj0K3NEWO0T7sqaIWyV4SbIcca/R9Z5TilYw
	 bka9pPbBqrMpUEHu7sDgDJqYE8PQi6QBaT//EmsZpCTFYO9g4wiLOzczSSJzVEJGFVMQS
	 YdD2GxGl2L00Vtjl5JFvcbfPE1OHwvPU+czvnRQedyrKn/XJgmLMUc33PwnD5PSNOmIRu
	 G1NkDFqgLdl0qKPJz5VlmAJ3vi0mxpmg/LkAzD13jHGodfB5GHi8Wu7uHLHROBPQGA4k9
	 /tU7gh4yrYXgp4puJqjskhxnqswAAOiDQiI+81HyDlnyyMmHM9GSIuE1Bs4/KS5y7aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8G7jyeT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EC6082BC8
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8G7jyeT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5987B1F008A1;
	Mon,  9 Nov 2026 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239649;
	bh=FxpWwF5G9wz/P+B+O2XIchuTVXbJUvEoMG6HTj+zUjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8G7jyeTAtm1WwSAz9AGivMI+w8d2Mu7P2+G12T005Hn3n2YQXI9gcjTZKECxLdLL
	 PuYhodcqIdQ92WUUXlm1G6Ca6tZAPYNpKhSzU0U/7rQxDPwkBeCiP3pV4zuYrOZPfc
	 B9QP9oBHW9vqrpzBV8NrTLGtN5SNfPnK0I/x7g2PHOoimccHTrVonigUetiT1aiGSb
	 fvCpiw7uoUICDhGXwBnvFwY1oyz1wgqRszsNvVWqDpf7lZt4DVCxri49dq04xGEWIl
	 ARcKG0XXgAR5+zrC7Fej5pbeZJvqReyCI3O0WdIJ4w16ou5YtmPGmiaJQaNIZXe7R3
	 Rm9UODFpkv5jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Guanglei Zhu <zhugl3@xiaopeng.com>
Subject: Re: [PATCH 6.12.y] apparmor: check accept index + 1 is in bounds
Date: Mon,  9 Nov 2026 10:53:25 -0500
Message-ID: <2026-11-09-1-daily-reply-0045-apparmor-accept-6.12-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109030614.419397-1-zhugl3@xiaopeng.com>
References: <20261109030614.419397-1-zhugl3@xiaopeng.com>
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

> apparmor: check accept index + 1 is in bounds

Both backports use ACCEPT_FLAG_OWNER, which does not exist in 6.12 or 6.6 (it
came with 2e12c5f06017 ("apparmor: add additional flags to extended
permission.")), so they break the build.

In those trees aa_lookup_fperms() reads perms[index + 1] whenever fsuid !=
cond->uid, without the owner flag, so the bound check needs to be written
against that code. Please rework and resend.

-- 
Thanks,
Sasha
