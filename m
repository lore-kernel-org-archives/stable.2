Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A188B35675D;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301916; cv=none; b=AwxRAI86fDLLgemdZbRYKRO5oRXgq5ZvtTdREpfaXNe3naJzE8E0TklMRhVppsQdO13n0aO4+OONS1/4TJNjNOj05aRsXh9LlbOjLCwbMA0kTwxNYBMEq2IAtkn8JF32FpZINOBhQqD0eSNogGlNFWX3ZfYoJlXYfyw+sxdJs6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301916; c=relaxed/simple;
	bh=7vjS1+99tVVub53wedPQVGlLD4jWThsbSsnqQv5gwV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YgdG0KwIy9YPeMaUJ9we2ab/P8dVHrKdSD76DjfzlIJjMY7H2+bH6oAuI4TZMZqXvAI0pJCSqonhRYHSmevqS/uYiyd7+WkvfroyMndSb92kewHJ2ZV5D17hP4TUB+FA+ve7cEwrt2PXovIGNOxeekGPjumw5LTF5rCwPFj3qa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7FC1F00A3D;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id ACD3A180CEA; Sat, 13 Jun 2026 00:05:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, WenTao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260611005322.53096-1-vulab@iscas.ac.cn>
References: <20260611005322.53096-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] power: supply: charger-manager: fix refcount leak
 in is_full_charged()
Message-Id: <178130191369.340022.1341060494195173604.b4-ty@collabora.com>
Date: Sat, 13 Jun 2026 00:05:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 11 Jun 2026 08:53:21 +0800, WenTao Liang wrote:
> In is_full_charged(), power_supply_get_by_name() is called to
> obtain a reference to the fuel_gauge power supply. If the
> voltage check (uV >= desc->fullbatt_uV) succeeds, the function
> returns true directly without releasing the reference, leaking
> the refcount.
> 
> Fix this by setting a flag and jumping to the out label where
> power_supply_put() properly drops the reference.
> 
> [...]

Applied, thanks!

[1/1] power: supply: charger-manager: fix refcount leak in is_full_charged()
      commit: 4373cfa38ead58f980362c841b0d0bdf8c4d956c

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

