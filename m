Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850840;
	b=jwF0W9vswtUtf+bJJsllO4vVjQ9hVTp/I2nlYXEtzlmaAi7dFGoFhC2plx8CCvLjkRKJ
	 QqaqLhL06ARTinm8opo0OBQXlwkqiCjAQ4G4EKtSs0z1Y2W5YHngb0oKX+jeDG4BWrhuY
	 Lz7az1Icwp8tArYqDeR3Obrc8Ub8E1WWOlUsssf26LXjfwAzew0dmLU0nL0iJsVmvzcDI
	 0Rx8jQVDW/UWN+neML5xYm3PIZoPTCKgw7doCCuolkiX1sYzKYeA3Y0ZmGmioQWIE1WPC
	 oG6XWDx5RGpw4oEpzMj0HoOU0ysrBesC9AluP3Dq3NSD0KkQPHdfLLVgmSynQizV+dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850840;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=L7inZMnxwnQdRY1DmE8RamO9WGNO4xHpPbo5X7Wz8xY=;
	b=j4gxO9cZ01PUQXrA3gF88k25zeuVkH0rdU1E16HnMGRstEBgflhKCjST8R0KnU6TTKay
	 VaxwKDIyhJuCC0/QcVnwaKTNOC0yv5n9EIA5PknLLajdcHKjEue+EUuMG0XynF3ZtWY2r
	 be/Z57DYw5ityLC4r3Cjl230+0mbV6FEOjVxcMgcV+LUyPy5FqmOa8YvW35cWA99xv/TG
	 1YIV5IJ4XQqQYi8amqYGNqMa11Zn1iHLEK1fZmkFOBaANwBg1Ck+K3GHOo0J29hnkG3vL
	 iIXMN5oBI0seFiMHchcWMdAz3YLgbOJn5VIe2NfCuro40pTtDEFdCF750Y8dn8rsX+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNsg+RRa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08F9606A322;
	Mon, 16 Nov 2026 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNsg+RRa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFD91F000C4;
	Mon, 16 Nov 2026 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794850840;
	bh=L7inZMnxwnQdRY1DmE8RamO9WGNO4xHpPbo5X7Wz8xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BNsg+RRaij9nHgBRJ7kJEFcQWMddMQTT4r40GeKJIdd6teUD3SlcQ+VZBHAB/nDAD
	 mhcAaGGZ/FtKAsVNINyu2nzueLKpRO2JGGpar3angzwBJG4fO/YAZ/s6gfg7mLftWu
	 lCuhiESHo+GrYYTN7QxKXGcyXf2g0h6Q7hpdtRVzBTpTfn0CROliQI9HEhfKH0O01H
	 lqmDLfJ4Kihf8rPBhvNMKp7O0tqWd2hC0e7EtQSQsqFNecvHi8MYVA4IisDsq018q2
	 ji9JXjsc/nF5hCiizyFk2DBkPzBiGjkYtJyBX1R9wWkKkoAPkoZXhvP3NNR7kWbRJ7
	 T2J/aL+uULKQQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Nick Spooner <nicholas.spooner@seagate.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@kernel.org>, 
 "Martin K . Petersen" <mkp@kernel.org>, stable@vger.kernel.org
In-Reply-To: <20261113151929.9586-1-nicholas.spooner@seagate.com>
References: <20261113151929.9586-1-nicholas.spooner@seagate.com>
Subject: Re: [PATCH] ata: libata-scsi: fix REQUESTED MAX LBA field for
 REMOVE ELEMENT AND TRUNCATE
Message-Id: <179485083910.2809582.11637404765557509652.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 18:40:39 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 13 Nov 2026 08:19:29 -0700, Nick Spooner wrote:
> ata_scsi_remove_element_and_truncate_xlat() copies the REQUESTED CAPACITY
> field, req_capacity, to REQUESTED MAX LBA for every block count except 1.
> 
> However, SAT-6 specifies that if REQUESTED CAPACITY is greater than one,
> the REQUESTED MAX LBA shall be set to REQUESTED CAPACITY minus one, since
> the max LBA = count - 1 (see SAT-6 rev2, 9.16.1, Table 74). For example, if
> a capacity C > 1 is requested, the capacity ends up one block larger if the
> drive can provide C + 1. If the drive can provide C but not C + 1, a
> request that should be valid is instead rejected with INVALID FIELD IN CDB
> (see ACS-5 rev10, 7.33.3.3).
> 
> [...]

Applied to libata/linux.git (for-7.4-fixes), thanks!

[1/1] ata: libata-scsi: fix REQUESTED MAX LBA field for REMOVE ELEMENT AND TRUNCATE
      https://git.kernel.org/libata/linux/c/9016b8b9

Kind regards,
Niklas

