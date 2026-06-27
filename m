Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A31717E;
	Sat, 27 Jun 2026 16:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578143; cv=none; b=R8AE44LV7QMfULGZuYE7CRBLOooa3IgHemTNfWsxZ90eKNsPfH/nf4IsZg/qZ8GDb5exj3SlJH8a+rRL0V9YEOjv94oz/zR0xxb1Nbw1q5pCtm7CzO9xuR6ZPyb7rpOwGbhuQLG8n0ZNjYE3ANerv0gNqJxF3ohY69Cn3tMtRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578143; c=relaxed/simple;
	bh=j81zY+ENowzvmHdgZU/Kabqrxc+PPWoHxK6BkPIFzDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA73b36s86hTE+msNkDiQr+kWgJDJfPJWEpAQL18cSZuW0jItaOHUxPlg0nfHkyxMPQZZTWuRAEkfz7MEu4b5TeOGirIYYoazW/gD7Ev6GGPw9oRcjOEmQi1oGI/1EUIPQW50f5kAdIqtr29riVan5caz7yz1bct6AC4jeYiz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR9io5fM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR9io5fM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B21F000E9;
	Sat, 27 Jun 2026 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578141;
	bh=/VhMs8dfIJPax9GDvj+2M3vwD2Sp7pTJxSUPoerARsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KR9io5fMceHNCq+qNTAmI0BsGhJnXVourx67Tnde5IgBlmZEi7msVrYzuC45KMXge
	 J1m32CMpIDGwFyXnpflmXlEcc4suaHc88uqgjsKlVuDUrUnBBeZrGHPrkEoElIZigJ
	 pva7NZBOxEUk7rHRW0Scta39gQJ+JPxJvWvqcONiVQUUa2YBOeL+w/rDupeqQSRr9/
	 NXa9dUFpMaxg6wLla8VWEVLHQ4z54lXiITbs3mOQED7XFtidcznvE/tLegrYX/PuuM
	 YAG0Y4gw9Zg8995hrgoszH/TXPqy/Nzv+HSXyei9sm9GmY+qVgFI50qizswnuZ1vSf
	 tXJ498WwP3lPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mani@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Paul Guder <paul.guder@example.com>
Subject: Re: [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 12:35:28 -0400
Message-ID: <stable-reply-item012-pci-qcom-612-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 13:39 +0530, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"

Queued for 6.12.

-- 
Thanks,
Sasha
