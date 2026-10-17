Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38801342151;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274196; cv=none; b=JGKI/zMHYMVLOZK7JNGK5NViaWsydbhpa9U8EmC3GgsGNEqg+/9ub5Men5+KWWLfJd1HPW+afm7Q619tahc87NqhoTW0i1cx/iag0FlR0WAz3Ate2eVW9M0u0DI/ODJ5RmAC/jWEmwSEje7ituPcdDsDx0LdcIqn9vQebWQ2ZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274196; c=relaxed/simple;
	bh=5ZPsLoEJodQ3pwl9rPZZQdVSfFrzD2H4J67Pnm3gOT4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PzXbF//uWOYn81sRFNHqwlzJkAik+I7O0VXz9jMbvnMxkMNHPSchaD4QZajQCNCAi0IM9LxKccoSf9WpT4zqyof5Leq9pS1YPtwt6WAtBpP9OBMRNSMYsLUfGEyxGpAXJdwUAhtknKU2C2v6zqbVV/qQ0hj0NHA6Pdu/HgfTshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D491E1F000C5;
	Sat, 17 Oct 2026 21:56:34 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 61A4418233B; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Fabricio Akio <fabricioakio@gmail.com>
Cc: Robin Snyders <robin@snyders.xyz>, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261002-qcom-smbx-enable-order-v1-1-7df92bd809db@gmail.com>
References: <20261002-qcom-smbx-enable-order-v1-1-7df92bd809db@gmail.com>
Subject: Re: [PATCH] power: supply: qcom_smbx: set the charge enable after
 software control
Message-Id: <179227419338.76434.14581539706136595064.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Fri, 02 Oct 2026 22:29:32 -0300, Fabricio Akio wrote:
> The init sequence sets CHARGING_ENABLE_CMD before CHGR_CFG2 selects
> software control of the charge enable.
> 
> The Motorola Moto X4's bootloader leaves the charger watchdog armed to
> disable charging when it bites, which it does after a few minutes in
> fastboot. Charging then stays disabled in the next boot until the cable
> is replugged. Setting the command after CHGR_CFG2 re-enables it.
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_smbx: set the charge enable after software control
      commit: 1fba787142011145e1071cee9448b3677fb2323d

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

