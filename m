Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF13CA497
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322599; cv=none; b=qgz7GpXBZGJG4PF6nkhP4rLUjrqtMt/2XVWAa55eBCF1/T9pB2OoEsxGAzrhD8wMYL5Pqw9YdaFQ3J7NbF3Cx3JCAJGqs3gNyiV0O4zmTH5e4raCSBKOTe9GFlNn1mP4s/zD2HsnKEPYsMSSYDyVdNcWp2xfkF1kJfloNoPkVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322599; c=relaxed/simple;
	bh=J8CHx+PFN2zhqjlgeYwV28nEImtloTU8Y0VEFyHJL0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lM2clVCJSSwk6Na2FnFEG46rxPs/WVCUrDKGarUZXrxjRxW8FCddqwuMw7eTO9mvs/+WMtifrgRpD7KjMfwPXPMbbwwQPw1hq9cJSU6+zRFG083GIyiQmHsJzf+sAZqgwm7aDj+NCuWUbZAPVDKlfAQsDwywy+iXKib+j6VycRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YH4dj5UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YH4dj5UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117101F0089B;
	Tue,  6 Oct 2026 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322598;
	bh=DRcxr66CioN3ITTGyf/uttjDEPVo0TlVxOyrDrlT45w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YH4dj5UFfWXySIxDy/KV4m7PODGN/l6besa261jHT/JlrvJWioVcZN52gtb1NIlm9
	 2q9nimjHRRi2WfwP3paVpyDIhidIa/4njjlz/kIjCj7yL4AKisrv/KaHIFfFsm4wda
	 ySDmVl22b71zqNYOyzpuDhVYhIqtGFw/+cV9bcg804/+fBjklOZDzA4qW/MxESmkpK
	 2yJUUTRps00wsozn4yRDJZCO0Z9HccLqJhFWUsWek43caTC/Ltnj8laAptSxU1F1h7
	 kEKKFwkWohZOb4ciB6k4QXwA61axYH8D5sZd/x2Zp0N5Cs64MPO14jm6dV2O59GI+y
	 LtdOHS+W2tb8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Frank Sorenson <sorenson@redhat.com>
Subject: Re: [PATCH 5.15.y] smb: client: split cifsFileInfo bitfields to avoid shared-byte RMW races
Date: Tue,  6 Oct 2026 17:35:49 -0400
Message-ID: <2026-10-06-1-daily-reply-0017-smb-cifsfileinfo-5.15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005180102.3978996-1-sorenson@redhat.com>
References: <20261005180102.3978996-1-sorenson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 19465a9aeb664f1d710d0d22c07c31bfb7c85446 ]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
