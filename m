Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB5A3D45E5;
	Thu, 30 Jul 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449393; cv=none; b=c1vC+0yuGVjv5Dsd25UsdaLL0T7eWfC9kf9/ZfaD9hBkN1i4W66XB715sY5lreP8G8PK7G9IxiF2kX4MEVpmAe8i2EfnVAFyLp03Z6BCNaeMhdVlUmElSlpGIz0BpFkitpWHWEf/XmimqdTDPFwI1l8LWdIkWe7pa6TMh+Iiq5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449393; c=relaxed/simple;
	bh=RcE0K4ANkxcFykozWaqkqkuVDeyYySv21k9rskHZR1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oEdED3vnmfcSJOghxL0Hw4n9Njl1OA2dl+rHv1kC5YS6lR4+wigslmU/98qbJZIPQpOBmc7G06GGoQRKc0TsZxHsPURclsKdmICtd+FUxVJWh7NQTGRNkhKfIgD+8KWMB09YmOLws40MlK9wyGihqynOoIaNC4qpEyjuVBtZnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC631F000E9;
	Thu, 30 Jul 2026 22:09:52 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id AFC331805FF; Fri, 31 Jul 2026 00:09:50 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 myungjoo.ham@samsung.com, stable@vger.kernel.org
In-Reply-To: <20260728030123.230202-1-fanwu01@zju.edu.cn>
References: <20260728030123.230202-1-fanwu01@zju.edu.cn>
Subject: Re: [PATCH v2] power: supply: charger-manager: register regulators
 before exposing sysfs
Message-Id: <178544939069.241335.6930700242897058437.b4-ty@b4>
Date: Fri, 31 Jul 2026 00:09:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 28 Jul 2026 03:01:23 +0000, Fan Wu wrote:
> charger_manager_remove() and the err_reg_extcon probe error path free each
> charger regulator with regulator_put() before tearing down the power_supply
> sysfs entries (power_supply_unregister()). charger_manager_remove() also
> calls try_charger_enable(cm, false) after the regulator_put() loop. A
> concurrent write to a charger's externally_control sysfs attribute that
> lands between regulator_put() and power_supply_unregister() can run
> charger_externally_control_store() and call try_charger_enable(), which,
> when charging is enabled, dereferences the already-freed consumer handle.
> When charging is enabled, try_charger_enable(cm, false) in .remove() also
> dereferences the freed handles directly. Both leave use-after-free windows.
> Symmetrically, probe registers the sysfs entries (power_supply_register)
> before acquiring the regulators (regulator_get, inside
> charger_manager_register_extcon), so userspace can reach externally_control
> before the regulators are available.
> 
> [...]

Applied, thanks!

[1/1] power: supply: charger-manager: register regulators before exposing sysfs
      commit: c57cb36f76eb7ced45f57af1a890d8f3a6d76342

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

