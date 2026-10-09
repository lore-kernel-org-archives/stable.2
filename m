Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6B3644A0;
	Fri,  9 Oct 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791572483; cv=none; b=tmXREc4pZeepo4Ni7MnZPy24Kr2rUjKNuNd1Ux68MjbgnRztEXcEdTt7AXb62CeswCu5TYw12mXwQVqaayHOTi7EYTzthrcx+36mzDLIv9G+4hGSNayehat1LkZy8tx8nnQE19yKxctD7JoCZb56X2hicxafTG+ik1KJMca8tsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791572483; c=relaxed/simple;
	bh=JnrlWnkjJ6jsvH05UWrvsCEmjyaoFNMoxMkHobABBMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsUsJAzOg3NvWm2+kNNIEjoS87GXOVUJQ5p3XWjkhJo4ERPJSv1+O6qrihSKJY4BlVEsmz2NP9I8ILC04dsYQ0xaOFqy32CsHzlP/hG+m7bW4ALiYU5uYOavo3MbXn/nqNIPAo6Fudlt8aIODxA/xE1GSYf7HvOhvRCQbLYOCFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQUebG5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQUebG5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF44A1F00893;
	Fri,  9 Oct 2026 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791572481;
	bh=wIRX1vhmNZyl1zDN3zoDjlIfETeVA6hkJSgEDSBU0DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQUebG5GYzOIefwoW0n/KQkbGyPm7n3ja7TprMazu9Z+TYaYERziq2pOL0Km6gxWW
	 E9vyaFlAIpJP6Ha+m+3I9FUaRRcaQ5rxXZmLna90X4rujkT4ZgEexbQcfciRMYz6Fc
	 X0LGiDryM9jBQpiPqKkgiVfNuPe9jeRtwbGK1j7OL+RYCSQ8FLJfD6XiVdjoWiSOKc
	 2JwBWoS8LEcbz51bZnSCK9jV68mm4/f1rHnqsPI0pG68R5ia28MMdJRcU3s9JDfZ29
	 YufkRRMctlT3dcvDTasjWQAPTGCM3Hu+y2yIaiUzJiqB/6JI6CJoiIedCRs+WAe0L7
	 L8O0slEL48bpg==
From: Sasha Levin <sashal@kernel.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: qcom-geni: restore tSCL with 32MHz I2C fast-mode
Date: Fri,  9 Oct 2026 15:01:12 -0400
Message-ID: <20261009145800.rc-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
References: <20260929041444.9837-1-daniel@quora.org> <1ca16602-fb66-4706-8e86-3b35372324b9@oss.qualcomm.com> <CAMVG2svsfP+6cpRq=kBCZFva_r8jXSm+-pp+qC9D372S10z12g@mail.gmail.com> <eaa6f116-7556-4791-857d-cd50c504528d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 9/30/2026 3:01 PM, Daniel J Blueman wrote:
> > I would revert the original patch if there is hardware that uses the
> > I2C 1MHz fast-mode, since the current timings aren't to spec, but also
> > weren't before.

For stable: cb97bf3d4f91 ("i2c: qcom-geni: Fix hardcoded clock index in
SE_GENI_CLK_SEL") has already shipped in 7.2.9, 6.18.55 and 6.12.112, and is
queued for 6.6, 6.1, 5.15 and 5.10.

The 32 MHz clock map (506bb2ab0075, v6.13+) does not exist in 6.12.y and older.
The backports there pick only the 19.2 MHz entry, so the Yoga Slim 7x /
X1E80100 timing regression cannot occur on 6.12.y or older, and I'm keeping the
6.6 and older queues as they are.

7.2.y and 6.18.y do have the 32 MHz table and are affected. Once the fix lands
in mainline, I'll pick it up for 7.2 and 6.18.

-- 
Thanks,
Sasha
