Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299428;
	b=FjdVMbilcgeszukEeWyC5F5Ksv99qfcwfSWLe4zOTBl2Vj7SUwmLV53DxRx3jVwMGVUI
	 hlwt0ahOAlzitiSU2VVIg7esoNof2fpUzQCeZmeWNTFzk0NTe0g9yamJt3g1a670Zbxdn
	 6qAjL+jNhjgjYtNy4tybPE4aXIajAMJuFBBT0G9ZMr9Hu/BiJzTVHSyqpO5+tL9GtiOul
	 aft7xnjP1RE12ZH+DHPJoMK6fFdcYhicYhekv6nlv4++Pw/DHpvyK4CI3l8Z+eU2nrDI8
	 QS4iuqHe5EgNtQq7SQkn3EZdwJ9Y5hJTcqyT6xlc8ZhsJnfiu3iixciYBMIFyxQNmBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LUhYckbXrX6yJppHSxsBYbUoZtW7rgRPk1KNQoVQYjg=;
	b=kR5ZVpRZttizaT9Y86SDsrKPfFq71MXIPv8E5LXpnLFZHkGvNTBI/LvT6RQ9/0NG929g
	 Mtot7O5/4tTEHDeeEYYZSIOTM74YpH6mtvACOftVOvO774d9LuclmsW60adck6MszouJ6
	 O2+lWN0a8C0kKggztmfnW5/M0Scs3dUK28sCVMhbYRoi34fxtQ7Osq27tNYMzz7P3A2/3
	 hzBLTIhGtwxZrCQqoOJxF+8pZ/5oPULTMme+Tk7Ky+qXdZxEhmC3aU/e7EfSfaFhQmxB2
	 a98cX8YpMxg3Ww0piydCbiVS4lEUULh+//Tz8zNa7yNi9zums2Zs+krTiQ43hiIFyCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKAOazR5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486A606A33B;
	Thu, 29 Oct 2026 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKAOazR5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92A91F031EC;
	Thu, 29 Oct 2026 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299427;
	bh=LUhYckbXrX6yJppHSxsBYbUoZtW7rgRPk1KNQoVQYjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKAOazR5Ti5pak3mzylgwtzMwkQDoVTrPhOJwB6klzUMHt106oPtPAAIU2dyGCT6/
	 JeyEWoPYCON/ePXou7ABNUGyt0veL3KY5jB9LDt5kHoV2aoVL5pIUW5hpKPSLX03gf
	 LsmekMj9SOJ+Zt3GhyZ2NvoS/1WOxX/FP/9HmjsGF7RtiGy4fu8qRuxn9deC54mCoj
	 ohxY8efFHWM1Zs+BkT5WUrebY9nG9SyY6y+VDj9mZziNQ3qt0pWBIRR+KKsvRjA4ZQ
	 e/DO7EwhuvI+aBZWVGcTitg4O2/sXVEMsWXUx2FSwIQXziJyXRnbUvYEgLWwaH3MqU
	 7vPoPf4GKxFKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.12.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Thu, 29 Oct 2026 14:43:19 -0400
Message-ID: <2026-10-29-1-daily-reply-0012-damon-zero-target-value-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028010247.158237-1-sj@kernel.org>
References: <20261028010247.158237-1-sj@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> If a DAMOS scheme has a damos_quota_goal of zero target_value,
> damos_quota_goal() could trigger division-by-zero error.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
