Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244E3009CB
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209271; cv=none; b=aqPjMtHkQYASg0CdgHTsgtquJ1r6V82aEBkebFzSOyZWjG8JDflciMPHrJ8OtLYL6csI3OpzuzlxptIRcxjRBOW4PGfB4naefBd7M/a28ERZtvkoM2ElSsYkb9NKFdpoL6kayt2Yq4/pI/PYDwfviQGQB/J63aqs3wJtdjhfSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209271; c=relaxed/simple;
	bh=DMV+QI+Xajfw0dB4m7F7usG2Gzv8astkxQFlNNeSd80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJzxp3KSEN8+Tp5crdf0xMbKM5vIbDOdZuX2WHHEM+un68CWLJIlu3PbDtokRdpg+0GVp3VQnrqOg285Q9SR5W+wcDS475xTQxmq/VNhCQpcLSMXijz8/McT00lUyXqGbaSgDW4zKxSNpCVTrD4+jf28Fu14zTt86WlPZ4qN47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y85mKo4F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y85mKo4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFC01F00899;
	Thu, 24 Sep 2026 00:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209269;
	bh=WgtNbxi+WMFjPP3qH75ZwVbvL3QEI1FUDTXFIQU1zsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y85mKo4Fo1wNoF1zoGirhtdUyjNN/E+uf3mQs2ON4+7YG0lOAcJ4n8MXGCcyf/dOk
	 IygLxr95O0S5ps+tsQbKyE2Bi89Dm10gUb6gxWztDIyrsYp+8pN2HPujcM5MQYKiWg
	 OMA0L4pJqTmNeZzhJVAeSSsUHUbCnHmFJ5Gk49I+Y3XR1fKUIWnW4aHuN/GPxPOmRS
	 OANEkQWNTHOGS+VAje3ZMpRPXwSuz/bfB9Fd+7AHiruplq0jeZjacAfup9s3Jbxwuw
	 8v33RxVXErkM1h8u/8hbcytpBF5bgQcGn69QFZO4DtZV26FcI8JE5AKl3+8bfKBjEZ
	 KuelsAnUbXQQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Itai Handler <itai.handler@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12.y] spi: spi-zynqmp-gqspi: stop the controller on shutdown
Date: Wed, 23 Sep 2026 20:20:53 -0400
Message-ID: <2026-09-23-daily-reply-0004-re-spi-zynqmp-gqspi-shutdown-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922140144.668363-1-itai.handler@gmail.com>
References: <20260922140144.668363-1-itai.handler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ itai: context only - the platform_driver callback is still spelled
>   .remove_new in this tree, renamed back to .remove upstream by commit
>   494c3dc46776 ("spi: Switch back to struct platform_driver::remove()") ]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
