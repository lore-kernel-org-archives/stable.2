Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DC636A34F;
	Thu, 25 Jun 2026 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384127; cv=none; b=Zkt+lEx4YOlc0Vpn2xsa6fHbV6R1WK/H7YT+/qeZDvQqKgqT6hoXyEBg5CeowX1V0O9+ztU7r+AxXwtcAClYYgkQniNrQ0h0WN8US0vuq3e1swLJgqxA3Wx1M7ZfkitTH+2+KFufZFIvWo6HuUj8LCMWSGQGkcPQcb1HpCyoy9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384127; c=relaxed/simple;
	bh=zkMcNaJSDWv3xcGECUXrWF9UiyDSLmH0igTKlE0o8C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/TnD5fM6y0AVkyEjYw2hm9LCaRV6CmhpVerF4XNPEW/7gfH6c0rJJvu17uEpBdBSE7wr1gsGbxB+XECRfGcH3trCZz5CLfK9JQZfTA/lA0sYuIjpqLiRN7xbKmLktqkByzUaFF7aL5gYWEa4qbaxfEupldQwsGJg6ZcfaQZKkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcmrGuqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcmrGuqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4716C1F000E9;
	Thu, 25 Jun 2026 10:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384125;
	bh=zkMcNaJSDWv3xcGECUXrWF9UiyDSLmH0igTKlE0o8C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcmrGuqSPhlvJkHbi3GW/+6yM1bL+DuVNeFGJApTj5fbiCE7ky3A9LTN5BcAVE4uF
	 OslWM8DQxvw7K+Ia19GbnrFerwCZog6R+pAI6OgP09yBddwsztkIu7QY/A9K5TDQov
	 YBbWHHqtnNwUZf6XUYepYh+YvFP5Cvn8qm+Ob61wDLud7rfG6LJUDlFT+xHI9w3fU3
	 3zz24xgJXcWfQJ8TsmbOV0dJhi0hjx9tRVoUmPiRaFvVxSWTBUq0UrGkWVwLm5Aers
	 mBcg5ziCxhgAlXIyT9VRNCCAqKLJ53Ilvs0y8yYva8FC4loZYDaIWc6o0teeivH1eX
	 yF+6oqgwiljxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	WeitaoWang-oc@zhaoxin.com,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	bcm-kernel-feedback-list@broadcom.com,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	David Wang <00107082@163.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH stable 5.15] xhci: fix memory leak regression when freeing xhci vdev devices depth first
Date: Thu, 25 Jun 2026 06:41:49 -0400
Message-ID: <20260625054005.0001.xhci-515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624034938.4126679-1-justin.chen@broadcom.com>
References: <20260624034938.4126679-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> xhci: fix memory leak regression when freeing xhci vdev devices depth first
>
> Pass xhci->devs[slot_id] instead of the reused vdev temporary to
> xhci_free_virt_device() in the leaf path of
> xhci_free_virt_devices_depth_first().

Queued for 5.15, thanks!

--
Thanks,
Sasha
