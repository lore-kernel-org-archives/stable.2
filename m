Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406989;
	b=Sdpx+7qrY/LMWktN9HLywxrBKchecUTD2eUQLyXT0MiljNARiXtt8ulCCLcZYlEoiiMt
	 B7rqBDv5tN/+0Q45q+PK6WNhAb8tPCilp+3ondXcjMXvCOGrJbv0uayhI/uzSdQyiWAYl
	 gDVYoE6bjGnsP2DWIXjJWbbazlZQl+IWO/rm7HX/hsFdMYbzhGnozT8PvMVOiDIUBFaL8
	 kxHcFzz8VMthXcKZNsSI7grO+wsIiz8MM2Fe1hKGIvvdcgNGD0aFWqQcg6u9NiqZS1QvW
	 F3Clw3LkWZjbR1ZrqAKddcaJz9Dt9TJ88CkQbbOtIGXpM07F4att7ARJeCdkMThpTLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406989;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=MfK+Ct1wnKvHqvVJNEe4WyjG/GXhOd1P262DUdXiVco=;
	b=tDFnarIcbMqTA1p49gm/g1C8wJF1/2jx35jHohS2XTBKsFH44I4Z8vVjwzzu26ZLw0Ia
	 xNF/6BnbwjYfPhP/NcI4WbH13SJx0VMdt7/nIHpgcicNirlJBzZAN/b0bLrDSZigD+AgM
	 n1D0qxW4ZYqeWiunMfcQYaasDwVMk66xxQRyW871S4KcYNFr6w2UriwlK49GyOpQZGOu8
	 uDmBsxXBYXhvhXWCd9bzE+bm1/Ff/FUfebQQQPAgObFbYybjjcvff7neqLZ9qno+iCG19
	 wvAnPXx0WNWzyDcFEbYnIpXa5zMWbn8a9T4+h25EEC3dGZQg9uVkjBmwMyHNuTI3gww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvkiFzwG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EFB606A321;
	Wed, 11 Nov 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvkiFzwG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCC11F00A06;
	Wed, 11 Nov 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406988;
	bh=MfK+Ct1wnKvHqvVJNEe4WyjG/GXhOd1P262DUdXiVco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HvkiFzwGImnaKNKtYjCIVV+gFBB7XIAz+YJXJdLRYAdfIoGcmJfXWDBvxBjlcJwlf
	 CeMaM2mj4NdV7AGmzNHXNh8sQe9rVzXiReC5w/JqsIBXdctouFASOe8OaQicgVtoBU
	 dlVokfIHnHmXhs9ZOQuYRgNfZB3qE9q9Aowh2SrlVEGSCoK6Tjiwuo+hRXUEcfaxs2
	 2RlxLM9E7Gij9WajaxbX+7tIqxw3dicsSlMJxRqKQfrSh7Mr53cw6HoZc6iaWR7XKg
	 oz4qFb0d8hRmMIthsq3NQPsStKXGUsUn7v6pBdn8tYzMOHUVq9U+G1tO1YFqlxIgqE
	 6R/UYIID5zQCw==
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Josef Bacik <josef@toxicpanda.com>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
 "Andrew G. Morgan" <morgan@kernel.org>, Serge Hallyn <sergeh@kernel.org>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Bradley Morgan <brads@mainlining.org>, stable@vger.kernel.org
In-Reply-To: <20261110144205.2404088-1-mic@digikod.net>
References: <20261110144205.2404088-1-mic@digikod.net>
Subject: Re: [PATCH] userns: Let LSMs deny the CAP_SETFCAP snapshot for
 mapping uid 0
Message-Id: <20261111-etliche-koala-urzustand-a80a430d8252@brauner>
Date: Wed, 11 Nov 2026 15:23:03 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.17-dev-ce4c1

On Tue, 10 Nov 2026 15:42:04 +0100, Mickaël Salaün wrote:
> Commit db2e718a4798 ("capabilities: require CAP_SETFCAP to map uid 0")
> records in parent_could_setfcap whether the creator of a user namespace
> had CAP_SETFCAP, because a creator writing its own uid_map only has
> capabilities in the new namespace.  The snapshot uses cap_raised(), so a
> task whose LSM policy denies CAP_SETFCAP can still map uid 0 in a
> namespace it creates.
> 
> [...]

Applied to the namespace-7.5.misc branch of the vfs/vfs.git tree.
Patches in the namespace-7.5.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: namespace-7.5.misc

[1/1] userns: Let LSMs deny the CAP_SETFCAP snapshot for mapping uid 0
      https://git.kernel.org/vfs/vfs/c/2397c70f7645

