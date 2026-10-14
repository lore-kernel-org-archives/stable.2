Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD73C4163;
	Wed, 14 Oct 2026 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981062; cv=none; b=k2jbCLlLYP1BjDcQNkOFjzI6KFLTFUFD4kyzICTLdC0GBbmN3umrFymkB6jlHaTJts//sqIIlNPQROTTj/8z4b13t4F8zcLrhEK9pUvJvaZq+RRYom2V3qJaZM4m///geN3WlFoDFYsUVglos6JAvL2lYcIZtUZ+alNRDdh4cXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981062; c=relaxed/simple;
	bh=bvxjmZS4X4Eqd5hZyX7kc4xljHOyD0evQGjjmXhkUbo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hppDSUB8lzgLooQLY5H5KDGHAhUjXUZXYSNUHbqNJw54sy9TKYbA3jaaMLdSnjcbKooiTg2H3jporagNSoT8PFkLYxjiRkTnTTqyHvvH1aXQSdbMAm/wni1YhVZawZoq9Md7ghRzJm61wfVWsLrtJVm7iP6yJHDb0Hc3uUVxIWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blfQHchG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blfQHchG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35C41F00893;
	Wed, 14 Oct 2026 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791981061;
	bh=WmMdzxPlejQaqZNa3UTkzpuCVe+6o2oOl7wZ2XqTuo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=blfQHchGOVRFFMFi9S0YYv9imMp5lzosnABYBn1sqEGK120DSF7lPqIS0uJVXR9pp
	 Q/LdcvPMrqGMPt4AlprwLZ5KMCClE2Q/08BMbMM05PuzGTTVN4J/nB5iBFSET8i1pP
	 b+7xTMNuYJMV7zGIkcTSjOT8z4lIOF8psQCjjB1f2OWbgPEW1dAoR1ln2yjfui3veB
	 mimECd9i9fZb+N4ls7BN1iaqTZBUhJIgmMa0B5INvaTZ8xZchOu5TdAoevFeqALSvT
	 mCvRcpP5GbhskOlHJ9ZkFfsqplq7C/9Q/ojxfWLiQ6gAEd6koP874402sMWAB+JakL
	 xJfDQQlFuEFNQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, stable@vger.kernel.org
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
Subject: Re: [PATCH v4 0/4] backlight: qcom-wled: Fix OVP IRQ imbalance and
 start from the hardware state
Message-Id: <179198105841.810389.574989948392370179.b4-ty@b4>
Date: Wed, 14 Oct 2026 13:30:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Mon, 21 Sep 2026 12:46:21 +0200, David Heidelberg wrote:
> The qcom-wled OVP interrupt is enabled at probe whenever the module is
> already on, but the driver still believes the backlight is off, so the
> first brightness update re-enables the interrupt and trips "Unbalanced
> enable for IRQ". sdm845-mainline has carried a workaround for years and
> Joel posted a flag-based version last October [1], which Konrad and
> Daniel asked to be replaced by something that does not track the IRQ
> state by hand.
> 
> [...]

Applied, thanks!

[1/4] backlight: qcom-wled: Fix NULL pointer dereference in wled_remove()
      commit: 1dbd46d4b2fb416a8202b1a8e4ef9d0cadbe075f
[2/4] backlight: qcom-wled: Fix WLED3 brightness register stride
      commit: 22672f81f0724cbabb272fd0228fa424d4306082
[3/4] backlight: qcom-wled: Fix unbalanced OVP IRQ enable at probe
      commit: 5eda6b51461932f9fd835ef9e4574650c69c4fe8
[4/4] backlight: qcom-wled: Read back the programmed brightness at probe
      commit: eacfbe6f9716d00536edc229a58895405e73c2e4

--
Lee Jones [李琼斯]

