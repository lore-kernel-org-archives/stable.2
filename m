Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A386382374;
	Sat,  8 Aug 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214145; cv=none; b=PE7wyDLntA+RhBCG1EmCQqktngxQNFWZcdiFKP87nmxuuD9x1Tev0l2TkPmhPEbngJMaCNjMc1ze5tLXMCW6WXTjMzoKct24ZvP/PL3J7m4OeOCVxIdJcUAgETC5tmv99lMJx/d/GHLuFvMID2LFYSmJda70n5P+cN98O62SXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214145; c=relaxed/simple;
	bh=jUjiSFQIl3BtPBeBBdgl+tVHECiutKG5nuaW0G2xB+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpMsaywwcC4obJmqVFTbv/SKY18BLMEasQwZ5NOCwu8jVSIswGRFjIxvEMCc8MKTWEaJNWKt0PfODygHmQ7I2LY8D5XrSfKrMya4saUnMuXnX6s0UQHi1AblMPTESMvFxTniHjMO11/2ux+1NFBvYUWjo6+KTA4BX7qYl00awP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfyaECD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfyaECD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60A1F00ACF;
	Sat,  8 Aug 2026 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786214144;
	bh=o0KEEUNR8mR+SFoRHY+bhTLUIfk8zA2xvwNVPzSAck4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TfyaECD553j9NYJ1bRDUzz8pFF45SWvvy0rgnsK1WJ6BWiCMcbfj61VREhQ98tXFa
	 50OPRrqyfG999o+bkAQey13G633Wk+0M78YjKFB02mufDnkBRgY43hV6Eim+YjcM4+
	 YU5JEAE3rVBvMKJU2HGS7CPe7Z0zDaOAG+YVjYwKxJyeO4hFocVpyigyfK+X4V3TTz
	 +OOnBeT41eLZd3AH+aR6LVSbbOLZJKxtE0BqGs2J5d7aY82AIIlxtfSfzweNpP0c0X
	 MafptAdiiXA66NZAXPZiD2NcYF0mv0+jwsITByul0bz09BWpTA1OSvSp0jIAksp60E
	 kER5OlztGmITw==
From: Oliver Upton <oupton@kernel.org>
To: maz@kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Cc: Oliver Upton <oupton@kernel.org>,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables
Date: Sat,  8 Aug 2026 11:35:40 -0700
Message-ID: <178621413201.380376.9463585617788229094.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260807025534.34125-1-q.h.hack.winter@gmail.com>
References: <20260807025534.34125-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 07 Aug 2026 10:55:34 +0800, Qihang wrote:
> vgic_v3_save_pending_tables() iterates dist->lpi_xa using xa_for_each()
> and dereferences the returned struct vgic_irq in the loop body without
> holding a reference on the LPI.
> 
> The xarray iterator only provides temporary RCU coverage while looking up
> the current entry. That is not sufficient for this loop body, which reads
> fields from struct vgic_irq and performs guest memory accesses before the
> iteration completes.
> 
> [...]

Applied to next, thanks!

[1/1] KVM: arm64: vgic-v3: take an LPI reference in vgic_v3_save_pending_tables
      https://git.kernel.org/kvmarm/kvmarm/c/f5b8f203bfc0

--
Best,
Oliver
