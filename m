Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB3390C89;
	Sat, 20 Jun 2026 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956506; cv=none; b=uyrHASzQu2+L267OIWr+44J7XKSPkx6VpezsvrLYuuuX+9g8PhU5MVJ6sldlOQba+togIZ6P7cHTyh4VeJwqttStTqFTWPLXkcUV6MpdNoe75t+nlEsq2zl85rPOEW9w3xsBatB8qz7Camr1K9R4pZGhPh33fzpqr+O1PHXnhb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956506; c=relaxed/simple;
	bh=jI3pjNiZUpnm/15FxIIxxHqyEwjuyajQANipOhaPPXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtN6f4HkOPor74E3JC/mmsN3CivZBLTpx3TmVCyEPVrS3qGY6cX6Bt7JNvZ4GaTMfaRBGB36Vfumpi6q8zYeMYwrMlqlCBp6Qw4MSQTo2BFo+YvG7XkDwjYZhVA0nr4EmAiCEA+/smwOoJVQ7ipglhHG2XtOmx/ZFqy7IWN6HBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsEIXqnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsEIXqnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D3B1F00A3A;
	Sat, 20 Jun 2026 11:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956505;
	bh=VTzyEbpsj67GSmHwMkKpZirmo3PjyW0vNzF73BEaW50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PsEIXqnjdpnWqeCuKHtBCHHDLyRxZ7x75vCZAtJXF0gAdj2U5i2NythDWW1Eghk7j
	 x7v/Tvr9hEr45TeSmM7Z+NB6YoGLJeumIfTTIp/nyCmYe4/ZtOKCYtFCKRIk/3IRo2
	 8PqByrVF5+mp0YcBmtRStefjO/lmse4IZ6g/AZ3/DBq0m6CJNuARj9+3Qj/p/8VmXc
	 5/rt3okUbXCl6XKz4C3MI/cUbHbZpuWtRJ3QeZMQcPHcEiLaJfeZtO56p/f+vT5TE+
	 E4wafxX1RPdWSjtaa0O/+fx2fQSAeiPSY7uzGwhNFLimX+lSr30dwLvAuUQTjndVri
	 ikF4/ONFetS5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaosuo@gmail.com,
	iri@resnulli.us,
	jhs@mojatatu.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: Re: [PATCH v5.10 0/2] Fix CVE-2026-23204
Date: Sat, 20 Jun 2026 07:54:53 -0400
Message-ID: <20260619.0002.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
References: <20260618080807.1269070-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH v5.10 0/2] Fix CVE-2026-23204

Queued the series for 5.10, thanks.

-- 
Thanks,
Sasha
