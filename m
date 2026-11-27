Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798931;
	b=pbv+5EBfGCjuxusdpbiNafrCyPi22dwH6Zv2LcP87xUEKEpv/MxcvA68uY+MjIouvE0A
	 WXUBSmqFuf51LnVF/YcT+JVhSbwg+l3nfTMi4b7fxB0BKJEFIF07k9T2211SKEAbqFkxC
	 plIiGJAY7EorOJeBKyZnXcUrN55F7AHLP/JLH6d4LlD7mg+86d7Z8RVDR5fuPFs5Ob0t+
	 6/G+bhXJiSiVpSk+uwhKKIiNtcO7QKWuenwk43iuOXkNQQrZMDTf9M7cbxFEBmwhqeE1n
	 r/z51HeQc3CfyqT4iiYH6wSyuMK8oebs1rpW2mGyXL7sJSvRUXmTvFNEjLqAFkq00XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798931;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fBOQ8bcz894+s0OfOxgXJhS5ssbK9PxKSOd26HM3S8Q=;
	b=5i9UCzbXs75gQ8oghRrSmYVWlUzi2I/u0dt8zO4ozscdLccoav8DIC39eOfILuFpt50X
	 hEw+FadL6xS5VTKBaMFMbWKyk9wwyijTdt3XDDR8dHQGyVvb/dhes5Ki7zZ2bhJ0NJz92
	 Bm5Jxvb7B5DSQIsclld2Kn5mQ7IVySYSc8OFE8dax9KKPdWgMeZJu48Scrkx7yitc0pU7
	 zYUHMV/kbfASSvKd33Y6JZiSlWzIFAJo60S66+YkWpYJMiTDeyBapQpHuj8XiKiS6ZZWN
	 3hIfeRu0wN2RI3xTgvgdu87fXjkpuwerkams3ZbfWN5lJ0nYuMAzelsCuiLHEe01O5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUYGGJR+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575C606A684;
	Fri, 27 Nov 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUYGGJR+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236A71F00A1C;
	Fri, 27 Nov 2026 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798931;
	bh=fBOQ8bcz894+s0OfOxgXJhS5ssbK9PxKSOd26HM3S8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUYGGJR+/0H5jxODAar/rMsEEg14BX6AwKp1phQTmIn0Y4zpR89jOm4LYFgT9i+KM
	 NOtlQCuxy/HB6Y7n0xYyulJC0MPm4jfpJwMl2uD7SKY0Awi+cFgarU6i1Kp9XKYSfK
	 fcVUaktBzonAPwnH9E/TOsSfIUkdFetq4O4FM68LhbKql9IZwmGqro/4+Fvk087mTI
	 mXeHiJfyvaHk66a9Z67B/gSaY2E7ZNYoPGdhqfNDn+ZKOiLQZsAQ6ArFzHvmaUD4EW
	 snbS14Tvg6F/eLFuaJI3rfQ0wgHRj6FDuZOXbBszq7okNPQb7wuPTpNz8Qhj73sagz
	 fxeaDLDI8Z2ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Denis V. Lunev" <den@openvz.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux.dev,
	Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>,
	Dickson Wu <dickson.wu@certik.com>
Subject: Re: [PATCH 6.12.y v2 0/4] virtio_balloon: quiesce balloon work before device shutdown
Date: Fri, 27 Nov 2026 12:01:10 -0500
Message-ID: <2026-11-26-1-daily-reply-0022@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
References: <20261126-virtio-final-v2-0-4cfd5590e924@certik.com>
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

> This backports the fix for CVE-2026-90129 to 6.12.y, the same four
> commits 6.18.y has:

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
