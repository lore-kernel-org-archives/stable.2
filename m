Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794787742;
	b=bbTJLs8cUjvZWipkBQnRovDD3m3dY/q/cydCQJgJF7xC2R/N2bh61WPB6HwAJYMPArTP
	 6n8a3vK0Tq65y/6bTqxqP+jJpde3qdMhYRyAvBPDOhOFb2fpXyTMvGVWCEiPJfKQAKW1d
	 vyj1mBkeFXfd3jvKo9RU5YCeiMAcxZWWYaOZC6aU6iVQ/EvFA68WI7Y18PpXUEUlN4Iad
	 ksK8nQD/4RQIhVU8MWNKqSWHPQxuW0DuniNnuhVW2IM+/ADbO4jpooPZlGI72OL0dqiHH
	 b+UuJ/unE3A2Hb2I21NIO4dRSCUQ6RgTxjOsw82JpViVIbBDwH4LWQwylpjTbn3jJjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794787742;
	h=Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=48q0AmOJmDQ3Fub1nn3sGagZCTyOAO3xFiG8C+bfaxg=;
	b=Lg5U+Mx+9dM+u8yZT/cHpmE0ZYAonF0CbN/cFjNviKq8HcLugbIcsTsg7QvolP0SkojT
	 CreAcZvon0kopIqkCZutvo7C965Ox93gHRVc4hxAyOfVS9eVeKaJqIcOZBSlwk6NknW6I
	 DZsJKg5byRFIPOFYx0l7NtW2d/eNkVwjjmFEwHRS01CnSS8NDyH394OTdiQZKqpGRgYu8
	 kZ3/XcQDssS+FHBWG3qB7DF+hnvkQEs3jeBoGhThXMjZ1j2StimTdBAFjivm88BkCllAz
	 yz9wwYLCeBvvDp8wZTlpr3hJP6s5lDafvX6UOSlg4Utyp0rbhY9pm6ZAs7ejJf0T6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F8606A330;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A16B1F000C8;
	Mon, 16 Nov 2026 00:09:02 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 399B8181BFA; Mon, 16 Nov 2026 01:09:00 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Fan Wu <fanwu01@zju.edu.cn>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261102-battmgr-client-teardown-uaf-v1-1-972fc5a5e0c9@oss.qualcomm.com>
References: <20261102-battmgr-client-teardown-uaf-v1-1-972fc5a5e0c9@oss.qualcomm.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: Fix pmic_glink client
 use-after-free on unbind
Message-Id: <179478774022.232281.11407040389078846321.b4-ty@b4>
Date: Mon, 16 Nov 2026 01:09:00 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 02 Nov 2026 13:41:17 +0200, Abel Vesa wrote:
> Since commit 4e40befedfc8 ("power: supply: qcom_battmgr: fix
> use-after-free"), enable_work is cancelled by a devres action registered
> before the pmic_glink client, so that on unbind the client is released
> first and can no longer requeue it. But a worker that is pending or
> running at that point still goes on to use the released client in
> pmic_glink_send().
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: Fix pmic_glink client use-after-free on unbind
      commit: 4f9bf356cbfb8aa6e73b1d05e182445723a4bb49

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

