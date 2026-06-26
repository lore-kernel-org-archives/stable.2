Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF3D39FCC5
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496487; cv=none; b=reZvgLBsL8leExfk4GsLd/g0O0/vuz4XOtU7Xy1tXaNdNCv31kajKUsbX70U0wJWqG+4dc9UwN0KxHPhDR6nKA3ZXHeLhq0NmjyqpBVxO+/JDRwxSB6CedLhx7KFf1gmbGm2GL6uFWYcEbFv6Vq0SiTn4sqW15EOI3dSXwQiceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496487; c=relaxed/simple;
	bh=hYeYswhNbYVkz5lna2XX9hHIVOP3LS3VM3VNs8Znmas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qC99bIYK8xwH6axnz7ClOFjEQgsN4MlWrVbu2AnrnzuGWEZrdWKX3n7jUXgeHcrDEBz5EjVm1HrOp2+koM6maHiAiV3SyHBTXalclSuE32MoPN2Yzg9OoQC1XKAfym9sGhTE2U2keb1BilCAYK2jPRjzTU3SVlBrRWsBhMkYRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et0CLkDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Et0CLkDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5D91F000E9;
	Fri, 26 Jun 2026 17:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496486;
	bh=fugFB+We4c4EF1mo4zAf+k4d6QkRuXkUMU8tF0Ui8Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Et0CLkDFoigxyoupQwrrTil2UbD6QJeuDTTlaCToJmaRRQ6jGRqy6v7NSvYZkiIAR
	 0Df5Upg6Mat1iW+aCtoCwzeTom7FHRdo/iikWWnxjCIgRACP4sk0DQv/TrpEi4z6fT
	 HrOaYJVJIszL7dnUbpH95q2sL/Pc8SlVPENCA4f47+i9smlOevqpvscBl8MjxS63BZ
	 DxLdWin7EiAkj4AUfTDSSegCwsHw+EXAt9hJvL/p0yFWywe7zRLfY51lkkEC9CxnZX
	 sV5Mj/IpCNDg1p8/OpnfD0xxqXKoKwXAa3odQ96pKY+RFodDeMrrkfATpAkR6AFRGO
	 7lMRXpukEs0mw==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org,
	Wojtek Wasko <wwasko@nvidia.com>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Yong Wang <yongwang@nvidia.com>
Subject: Re: [PATCH 5.15.y 1/2] Revert "selftest/ptp: update ptp selftest to exercise the gettimex options"
Date: Fri, 26 Jun 2026 13:54:17 -0400
Message-ID: <stable-reply-item003-ptp-revert-515-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <99e19551955b903936bedb1516bd2502c40f9505.1782385817.git.petrm@nvidia.com>
References: <99e19551955b903936bedb1516bd2502c40f9505.1782385817.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.15.y 1/2] Revert "selftest/ptp: update ptp selftest to
> exercise the gettimex options"
> (+ 2/2 Revert "ptp: add testptp mask test")

Both reverts queued for 5.15, thanks.

-- 
Thanks,
Sasha
