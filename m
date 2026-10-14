Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A526982C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005464; cv=none; b=D2QWU9H1NgDRdXXosVAoh50vXuJmTo7p5Bf3h8Mr7jAi7glIBFGk5Hsf9Kor6GUo279bwUreuP+enWxRlx2PGJc3M/rkQq35cPDdaOP06l3wd2f5pSsP/V5+9yGhh0KP0NIgx/FDfN0N8dzJb4n8zCTO1aVArqxm0mz0Aes9Eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005464; c=relaxed/simple;
	bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdR8TQ+PHhv08tdt+JRenGvTpa5+s/7xXb9dbYRMYh2+cyYYUcsO8RmCjTyeELQ6fGOFgjCkQLJZjiCaHwHhxK7IiLtw6CH78s+08iwjjRGZE6idWmka40c16wRYzVDX0Df7q/Z5wBPkZel7Q5g3ErKxPYRpZzYeTQsuGzwghJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Antj8T69; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Antj8T69"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-141395927feso8686599c88.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005463; x=1792610263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
        b=Antj8T698Uu8KnoVQxLBNxgUEgu/rx6XfUjDg1Q3Lw7ycXakzrb/b5k9kpyAkjYWrR
         bYiiTPW4q7fjAQcjnqtEq+nOFs6W4q9fv+5OdSE171nsZqfGWhCzsDkY9QmQnnVFZs0V
         aP27KKgUyaTQLt4X4VU1jzlSSHXVlXMiisOmGkjyP1tGjW1/UAvHc2hIhwhHG/x3gIya
         1IlcVhZxe2ejNGWP+J8CZkBTGEYFJrRhe/J8yBFdEuOrETbG4mBi2B3sqC4eFgW/YKIr
         AewNxP3197uNcVJFMCYLhFjUlut/wYyG0/pFnbsfi0PLFKWW8xRweMM598WpC09qMlEq
         0ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005463; x=1792610263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dry7BOloPec2zHiaJVfGwIFIpZZUOGvDPbabm8O3efk=;
        b=Rra1GP7ZR8OY6bdVAZBC8iPutbDGWwXYPvsS5zMY0BCe8c7Rk3KhiqkQfxTXOXs+6Q
         hnk3VETP02w2nOdN0x1kpDAKmSDiejn8Nx+Iu7I0L5xesnLzJFJdV4JzJUo2ORtQuyXw
         R23PfTUJpV72dbed7VYmjTfXVcAwS1v1SNwN9l7vpfoawlaNjVyMowF5cPrMd4Z/w/yJ
         OElY5g+0tVIPqqz+Wuyh8JFHceeGH9ZG1CUbQmP9OShnFIWE4jNweeIkMWwbzlP4cBQd
         Rnpc/n5ma4S0VeKZ2+NRRvT2F1y9AetzG5jmdKWHuSN2L8vRjnxeG19uWDsYVsXbe86G
         1D5w==
X-Gm-Message-State: AFq9FYIaBfBwgUt+2L1msZQcAuzVmL9HryfD2+doGIj0JbeenRVRLS1c
	7Cujt+7ydGjatACngsQAiIeqPMXRSsfOBYGjTeC58DAr6jnCJjM/bxa1euSnvy26U9JxsoK9H6L
	+vFNlnL/InA==
X-Gm-Gg: AYBFou1xJnJ4AE9b0+PPvvxohm9Wuh8N+MVQPC4PVkdVOKvDPUeyXMy276nMaj37iYn
	0j38cGn1shqx8I930hn+9FD4WDcpgMpK6nG3OAuFqqVlAn5IVqPLUpZSd4XXxzQ7xF3XXCQXosL
	vfYRQ0ZQLv1Lcb7aV5ai7tPT81i72CDvieABNO/33IYKpOMAqsHToCkxjc2VXFVz6N5HUoIorYG
	aFmvjqSAxjLMrLp8dNYnPrgyfg4L6KmPmkzr3DupyXiJPno1bDReS1+kouTi8w0ZxJ98AirIlml
	hi8Eg7sqdl/EqYl48gU0xCc1tZSOKcYIHZVjjDaCodkVD+1ga+B5NZXWBhONMrsZiHWPOsaxTqU
	QlPAtee1bvCyxM5uz137Fkhk+NLtyCKBaSE1SFRBZT4Us8kdy2Bf6NUC/YI5dw3LYL/79BGPxJM
	bS+00v3eyv1FYFU7hGPKX3YLhPYYvqqt4HKocFgxaOlUTL2N+a1NhtK2pmC/a7YRGkbWdNuRQ4K
	GhyPaQzaKoqa3E2plXnrXRcywXIVt0bUsbnhK79iJjAFZ5X/kRurqfr3rPcPLWkoHKuTgYLFxo2
	6/Vl6A==
X-Received: by 2002:a05:7022:ea8a:b0:165:1f2c:5c1b with SMTP id a92af1059eb24-16a57b0c43cmr23608713c88.4.1792005462662;
        Wed, 14 Oct 2026 12:17:42 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm28966433c88.13.2026.10.14.12.17.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:17:41 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	leon@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	shayd@nvidia.com,
	tariqt@nvidia.com
Subject: [PATCH 6.6.y 0/2] CVE-2026-22996, CVE-2026-23035: backport fix series
Date: Wed, 14 Oct 2026 15:17:35 -0400
Message-ID: <20261014191738.24034-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2026-22996, CVE-2026-23035 to
6.6.y.

Apply the patches in this order:
1. net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlink priv (fix)
2. net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv (fix)

Patch 1 stores the netdev for suspend, resume and removal so cleanup
survives a cleared private-state pointer. The older removal path obtains
the hardware device from the auxiliary device and unregisters once:
binding follows successful registration, and the target profile changes
keep that registration.

Patch 2 destroys the stored netdev without relying on priv->netdev, which
profile rollback can clear. Its code changes are identical to upstream.
Apply both patches after the pending 6.6.y backport of 3d5918477f94
(net/mlx5e: Fix netif state handling), which fixes registration-failure
cleanup.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y), changed objects only; no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
