Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702050;
	b=S7uc3KXb37HbYFHTCya/dHrVKKAK19TokcEd1pbtYNGpKs4iuwqvEpuIUyj5YB4d/xSo
	 GVCf0nNUOcrq9eMq5OpCXUAKzFf5C8tX+0Fl4I/Q14QSMPYCwUacjrN2SoHpWqRQqOqXI
	 +G82gEwv4B5Hn37096o6Fsi3IwYWVR80F1pVs2iR/3YI3wuNzjDBBCOlTvJdq5/fGCJpt
	 j4wYgBSzTj95xrV/npDTYOd9EpEnSgNC4d3Ravb8yLJeCpwBq6z/x8UwsudjX6uUCYlXz
	 /o/pDr+3FFYY81RC79C3FABNKTLUtkV/38/yKedF1fTUp9MPnAlArLsRW5N1xe3BRGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=ElZ8i+Cu0H383a4Cnzol7T75WU669apfj8mK5UU8k62NRytrpLaDQHhsADgEtZcJ1Mlu
	 UIL+4zNJ/NH7naa4MpadejRuTqVwi98vZu3H0+OO9aGkQ7e0T6cVcm8ZxuC4cEkxu8QOK
	 lI+HQP07lKadTsxBmTa7lvz98yMUwY38w/9yaM9cdSSOgIa5NW2/oCPSvkXRSFUz9LKs1
	 illO5+sOcJB+IPTk/8Oh5MzLXJioFoJ4fqAVqIsziV58dqG252nE84VlGxi4/xWYC41H4
	 Np2nlq2NlwiHDRFeu6eJ4t0f+sr1n7q00cUvZYL+erpI1FwjM1RlA+AVLEmBR1jh0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZObSSxO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672D606C5B9;
	Tue,  3 Nov 2026 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZObSSxO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F5B1F000C1;
	Tue,  3 Nov 2026 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702050;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cZObSSxOSZQWmBulA5loTfX+tXhZMEE3HncvIzlvUELgjg69OvaLJOT7AoP1OItI8
	 Mq0pPNt8NXUQiGF1X4dloCUIfVDBRpM0yJPv3TrpsrGTyNlRrfM3DmYMwxbuhUVk+I
	 sg1CyNHXpRMlMw1I1hasm+pJwRtyWEbK9yPVJ9VqjQoW+nqtc67v5eyEPYVrikuZEn
	 y2NhwrRWrrsH49yz2geNCfw/FkrmRehaYs5lKFAkDGyhT31OLs85hy2eNC516B+pYp
	 oKIm0Z0ueZGsFBUBxdc+ToPRBaNZHNPKoNzIPWAQbhy3inLRkcIwPHjVi+BmAsr8yN
	 Zaih7I7HPPjUA==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] igb: disable the PCI device when resume fails
Date: Tue, 03 Nov 2026 10:34:09 +0000
Message-ID: <179370204942.488859.12490720807858636370@kernel.org>
In-Reply-To: <20261103102849.1340413-1-vulab@iscas.ac.cn>
References: <20261103102849.1340413-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
