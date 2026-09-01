Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A03D813A;
	Tue,  1 Sep 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228592; cv=none; b=M0VUhOl00k5zZ57h626FSKTTtmEA8R3o/kUKBhKIYz6aWXMPnQvNY0Og1+2dU7Zim96XXyjMK8X+NMkAKN5btp2f7Sdu1fG/lJLahpweif7hqS4FeXq6DHcNm9iAebZW78SCpmkGFNX/v0Oc8QqyrqttNxPo6HDC7ckN+Tzm0q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228592; c=relaxed/simple;
	bh=l7Y5R+RcuBalj9ltU9sWOUIWnoxLyua9UyvAPjCU3z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHVincnWEN8YQRk4HHRc0mLtoFQkNyGgdSkWUQyXuX6igFguypQnCtD+QSf8hDeP2GPFAABQ9EAgkzxfLf3TLiXXiHfYLF1bf01endS5GFHfH3PboWoG4n4LhfFrggZ+WFt3cRg54rchAUw9RP0qLQP47i7ImOFRUz16xY/nZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu5FSG7m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu5FSG7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774F21F000E9;
	Tue,  1 Sep 2026 02:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228581;
	bh=yUjGXUBa9DezGMlAnGoUsZgKZWmW1EPVAHQea07ClLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cu5FSG7m0hrdMHX/bBC76wxOMXbT0b8epq/eEi7JpadPXAtl5CSddsCIzRfgW1jRY
	 DP6jLccXXRvQDJpGMVUzMmk6uK7Fz3WbBblIZQ1LMhNtkd/+XpVWAcQCvIJmMhe2qc
	 B0R3X9a2RBXESB4GzmIJKNZgRRnDb8DmGU9lvTQNgQDlxitk9bHF6So9Jq8K+tOTzC
	 KY2I0wylZpGUm2ghrwY4KAP+PFjlrCVbz6Z7yESCVfa6FNMEFgPNZwi106dbeCe4Ix
	 JvGA3Tog4ESjdsGhBC71E3TZyYzCfi3+F5esl/pd1EMkUvaoY+Tg+I4s+RyGT8N0As
	 Y0cpN0nPKbFXA==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Johan Hovold <johan@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org,
	Abel Vesa <abelvesa@kernel.org>,
	Casey Connolly <casey.connolly@linaro.org>
Subject: Re: [PATCH v3] soc: qcom: pmic_glink: Fix device access from worker during suspend
Date: Mon, 31 Aug 2026 21:09:18 -0500
Message-ID: <178822856279.1835959.17069530471298841498.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v3-1-169b00e0d9d4@oss.qualcomm.com>
References: <20260819-b4-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v3-1-169b00e0d9d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Aug 2026 10:23:28 +0300, Abel Vesa wrote:
> For historical reasons, the GLINK smem interrupt is registered with
> IRRQF_NO_SUSPEND flag set, which is the underlying problem here, since the
> incoming messages can be delivered during late suspend and early
> resume.
> 
> In this specific case, the pmic_glink_altmode_worker() currently gets
> scheduled on the system_wq which can be scheduled to run while devices
> are still suspended. This proves to be a problem when a Type-C retimer,
> switch or mux that is controlled over a bus like I2C, because the I2C
> controller is suspended.
> 
> [...]

Applied, thanks!

[1/1] soc: qcom: pmic_glink: Fix device access from worker during suspend
      commit: 7d0767c5cd878707fd6711023731549c83563840

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
