Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21393F44FC;
	Tue, 25 Aug 2026 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658588; cv=none; b=ZSzYXQC/1dpaCM566bAtHLDNRn2LXxDijdq/1C+d4eD7LlxXFnaDH/RtpZxExfWxvTmSCGRPil3sV+jA7/QF/t2gDAwjAQ3cZTaFtNrGUrDnrFwwmHg496PtiRbNoGkVG/jAoOVQlhp8giN29YCD7fIbBzLpiYKapaIP2w1fimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658588; c=relaxed/simple;
	bh=U4focIPigaKOAbs1/yCdWsn17vJZ4WhgINn016MwJuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUJnUgm/iMYEba0JDqlD885fuWa6qCM5CSmrR9M6JijW5j97/bietQ5VAM9V2V7b7gHB7js+p1Bc+jHmPQKL+MZuuDBb86dgqF61CZkN7rXDFEGHl8Z3i2AduLmL8MaKkivwUOEhJRzT9fa9+Ps68UduqMxWxjEbP/O6JO2qFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aB9yi7uT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aB9yi7uT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720871F000E9;
	Tue, 25 Aug 2026 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658587;
	bh=wCB8AhNKNLb8OIJakAuzswYTw4CEy/aGmWydCUuytu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aB9yi7uTgq86OsXrZct8Oi+XCie5hlBTTNZWZqzkIUppgp4C8eDVhVX9oPeuysHCg
	 SF91Ik4zO+nbOp3C+6uZoEKvWKqsq1BOAGVYsoAC0tQN9kETSGA3n+tKtxVA9cv94C
	 /gYlrqbMQ4mvrYiric2DW7jYFLj5t+yY07hdGeouwZRp4/gtkfritlE5/SriPOhwJo
	 fgVO7Ag7AQrhRY/mRqXGbfcCn7Z4qcuF5d2iPlsw4uhnbz7/4+Zn/l6p25aSEgn/OF
	 wpVv+8AIp/NVao85v5XsIvWcPxNt/OuMAW7VXDvqhHXWasUcH8suLfA+M4Fh9TqvaE
	 41koV25FDCpYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexej Sidorenko <alexej@sidorenko.cz>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Kamil Serwus <kserwus@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan"
Date: Tue, 25 Aug 2026 07:49:29 -0400
Message-ID: <202608250008.c25c563b74024d19@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823102959.100368-1-kserwus@gmail.com>
References: <20260823102959.100368-1-kserwus@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Aug 23, 2026 at 12:29:59PM +0200, Kamil Serwus wrote:
> This reverts commit 5ead2063611ae56809b1b113ac44cef9547c81d7.
>
> It sets HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B, which forces
> the legacy LE Set Scan Enable command (0x200c). That was validated on one
> dongle, USB 0bda:a728, and it breaks others sharing the chip id

5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended
scan") is still in mainline, so I'd rather not carry a stable-only revert
ahead of it - that would just make the stable trees diverge from Linus'.

Please get the revert (or the detection-based fix under discussion)
merged upstream. Once it is in mainline with a stable tag we will pick it
up for 7.1.y and 6.18.y the normal way.

-- 
Thanks,
Sasha
