Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793128235;
	b=b6B+MK095syCUvOKl4ovz9x4CkXICsjSHRTHChcH/aQStwTJNIPvV8Q6AgUV96l6lTAN
	 bRgj4uRW7bloZN+Lj3VsnUTfP7WGDAypMN2kxgefAyaZPhtTz2xPvkUCrmNrvmPwBhPht
	 a/jWO/3w0VTSjPsNzOoSgh6OKbl+zOMPxJbL5EuEYJqTEwl8tnRm1+MYWStc/cyepgSjO
	 8sF9wVT088KTKPDsmNFaSx652KHW6XcwixgNwqmWtDlirUAoTOj3FiojwKnJl4ioUaB/M
	 a1SEDjwAO6wVZx1vZXuG6UOhTxRsYa/C/pF2NI1L334kZpoDuMkKswjogulOByFqGeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128235;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R9tEvD3RQnaOKDvaEpR7yHiYeRZLJ2/C83lWlPtHz+Q=;
	b=HyqtGs5mAvU35vd10x0YQ9yxM/lI3xHTDCRxxET8Hdp0TBmqw9B+r2x0pkguLKTtdMNP
	 1zfn6yDh/G41R9ouIIImoVCKwK52o0zqIqGwuk3TJvnEOjY7gIEBcQTZXsbPZfTnObPbo
	 s8WRKt8/BIKMvxnP7EfWMvM/ZmadV/T1PpuwEKk6zEFF8taKkOfIo1Z7KikrEp/b5Qc0R
	 iOIKkgg4auIvsH7FHgtpYgGzDT4x/31NJlucxmwz9HlqyvKVGaWKO0Aq7VMnQc2ctftRf
	 Y0cZowi9HhkG404psYp0Vd63ovMkPQia9AU2YsZe6kvdEJ8oKZFJvsmtSU9e19ILrvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyq8B7hX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87073606A323;
	Tue, 27 Oct 2026 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyq8B7hX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CBD1F031E3;
	Tue, 27 Oct 2026 19:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793128235;
	bh=R9tEvD3RQnaOKDvaEpR7yHiYeRZLJ2/C83lWlPtHz+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gyq8B7hXnvvF/GhCPU0P4VNCDmLXyTU3TtZzK4RxDXN/EOyjh8cguE+B3/XWGqGfl
	 whtkEse+JxoyKYhUC6s5+j0B/+ozSOb4LKcMJxGYN4u29UzZDCGgghz9hSQwV0UzMR
	 /SHpTNqVBDuxi1ZFVTVFMTS/SSgHy8sMoxlSXT4YsfECiHqjKvuBNBTLpINVvWjikC
	 7pExURWQqHcpKvPq+fqtXqXtNcxjxXsAe9E/1RC1QD9ADZYaryLkPfOPi1v16X9JM4
	 uiCTBBA5/MtpG5Hc05q9Pn/zyR5QqQA1x9wI8u0iiCI7JVM7kDVDNPCgRBGwOIqSQW
	 bZsK28p1TBwbQ==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Marco Elver <elver@google.com>,
	Maxim Krasnyansky <maxk@qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pauli Virtanen <pav@iki.fi>
Subject: Re: [STABLE v6.1-v5.10 0/2] Bluetooth: L2CAP: Follow-up fixes for b66774b48dd9 (v6.1-v5.10)
Date: Tue, 27 Oct 2026 15:10:30 -0400
Message-ID: <2026-10-27-1-daily-reply-0002-l2cap-chan-conn-followups@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027100242.2886699-1-lee@kernel.org>
References: <20261027100242.2886699-1-lee@kernel.org>
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

> Backport the two follow-up Fixes: commits for b66774b48dd9 ("Bluetooth:
> L2CAP: Fix UAF in channel timeout by holding conn ref") that did not
> apply cleanly to v6.1.y, v5.15.y, and v5.10.y.

Queued the series for 6.1, 5.15 and 5.10, thanks. Patch 2/2 was also
missing from 7.3, 7.2, 6.18, 6.12 and 6.6, so it is queued there too.

-- 
Thanks,
Sasha
