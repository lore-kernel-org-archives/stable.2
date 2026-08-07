Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB4F3A960E;
	Fri,  7 Aug 2026 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129567; cv=none; b=l+/WLRRjoQHyz8tc/J86b3cR3yiy4JpM0AumKWm3EXMdfHF+md1d6ZalBe8e7poS/pAAQcg85+XS270AUgXLxsv7mD/QMTrfO39ZcHcWhba79wZr04n3m7NK0UtpGAOKLJ9dU/DPXc/3bRr5ievPxP/sx5qvsW9mXLSF3Zq2HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129567; c=relaxed/simple;
	bh=Q8Cv+aJJzg6Mf/tfSbc6J9SFpoIS0/p9jJgQ7cWyii8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFonIJ8uFCaDAgVIexx96+//2Xg1IiiO9UIaZqF1vVBDjFUHWgCEoQ4SjfBK66daEHKYKyyvfiAHURGPod0qbi23/CM8umYpDjaQDZFtCJVa+3W6+QQsYavcmCDz08c615rx63gQyrLA8LJmcMNxp8IlYEUdm1SwRTwW22gEA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa432Ax8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa432Ax8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFA81F00A3E;
	Fri,  7 Aug 2026 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786129565;
	bh=25DT0XWWuqQZK7EISG9GktvGDoTk12melA2fkjZY5sw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oa432Ax8JVHmkXpMcBl3DVJ+He46NjsWk1xFAbizCBqyQxoHM+RanUd3GcMXL9OJl
	 dFLZKgbtF2LZJW7qga0zelX8Mr92GJ20irwgIo/K8CfIXZIL7V0IJROowRi/M1WF1y
	 MjCWdiG2hQqp5LLP07m+fbG+azuH+7hRatw+MQjWEsjEYVV4StDrJnjVkFZ3z7L37j
	 1hKh08p6y/czmPLXS8IRtIX2Y3dRqFiQTBOw8idfWrrje3dm/waeLMN9Zr9vJ65ePR
	 k/Z8QN8bjCgfdWnrSud6E/2Vv/lvMN/VfUNO9FkwwRuMTaZE8OKYNg5Mdlv1nWctRt
	 geA2DuskKXAcg==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	Pascal EBERHARD <pascal.eberhard@se.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y 1/2] spi: cadence-quadspi: fix runtime pm cleanup on probe failure/unbind
Date: Fri,  7 Aug 2026 15:06:00 -0400
Message-ID: <20260807182230.stable-0002-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807-cqspi-pm_runtime-v1-1-5973a0a208c4@bootlin.com>
References: <20260807-cqspi-pm_runtime-v1-1-5973a0a208c4@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Aug 07, 2026 at 01:49:20PM +0200, Diogo Ivo (Schneider Electric) wrote:
> +disable_rpm:
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_disable(dev);
>  probe_setup_failed:
>  	cqspi_controller_enable(cqspi, 0);
> -	pm_runtime_disable(dev);

This teardown order is inverted relative to upstream, and it reinstates
a bug upstream deliberately closed.

pm_runtime_dont_use_autosuspend() runs update_autosuspend(), and with
the usage count already dropped to 0 by the preceding put_noidle() and
the device still RPM_ACTIVE, that can queue a runtime suspend, i.e.
cqspi_runtime_suspend() -> clk_disable_unprepare(). The following
pm_runtime_disable() does barrier it, but control then falls through to
probe_setup_failed, which does cqspi_controller_enable(cqspi, 0) - a
register write against a potentially gated clock. That is exactly the
unclocked access 233db2cb14db ("spi: cadence-quadspi: fix unclocked
access on unbind") went out of its way to prevent.

Please mirror the upstream ordering from 5e8bb0cc72f1 ("spi:
cadence-quadspi: fix runtime pm and clock imbalance on unbind"):

	pm_runtime_disable(dev);
	pm_runtime_set_suspended(dev);
	pm_runtime_put_noidle(dev);
	pm_runtime_dont_use_autosuspend(dev);

pm_runtime_set_suspended() is missing here as well.

>  	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);

Same ordering problem in cqspi_remove()...

> As the history of this driver in mainline is convoluted with several
> rounds of fixes it includes the fixes from two commits, namely
> commit 5ff4d5d1af0c ("spi: cadence-quadspi: fix runtime pm disable
> imbalance on probe failure") and commit 5e8bb0cc72f1 ("spi:
> cadence-quadspi: fix runtime pm and clock imbalance on unbind").

Please split this so each patch maps to exactly one upstream commit.

> Fixes: 74b0b4cf13fc ("spi: spi-cadence-quadspi: Fix pm runtime unbalance")
> Cc: stable@vger.kernel.org

Both Fixes: tags in this series point at stable-tree commits rather than
mainline ones.

-- 
Thanks,
Sasha
