Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F38313E31
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252283; cv=none; b=L8Z2ZaNNAIn5MKQLUf8W4KAzzfqL0g0BNM97U9S/J9iEoZYfc1Vt2ONAaTCk2z3P67r1h9T6+31tgrMnYa6+z1I8IhBPDtDb1vjP3FnVAEX5P1ZaZ26FJpyINpmJS1LRyy5j/CmQ+/1xOurq2Cbz8Ln9uTbeAds/fjkjR6Qmt0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252283; c=relaxed/simple;
	bh=YoRtbDynAgWjD7eyZ7AJZvUv5s7Iwzvt6Hp7UsnKjCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt/w751NzwSBeN1gbLQ6PYLkhC2JGjeDt8mGFs6oFlzZDzh4uAMHGKmTVSAWSU3zD3kEu8WQw3OpDqD8Ojdt7LD+UQtyrK0ymzWgeG4Az9On/O4sPhGz9gvesoPykepu51tTu2oW3/CBFkF0zzvvSw0HsTnpyYxG20A5nhik0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pn0MtQqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pn0MtQqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACC21F00A3A;
	Fri, 17 Jul 2026 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784252282;
	bh=kLOlGnrEe+CcI+ONcem8ymWcEye4PuZ2xV/j3N2Rfo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pn0MtQqiNknME16zcIFjhKpqObhKMhspoj8CYbVhyYDTvfMidbEK9W9IkrjqNJoeV
	 wQO5q4jpOLRF7mCEjSq7/Xc3HbpuAka3ENflWQwGCjiFrv4U939hA+bgJqKz0JhATB
	 FyJaluoEHFs4Er/KOiPkFVX9pZQRgi63QBdzAVzxxbE1IN22Bb5br973giE6MbgwSq
	 ReJ1T+xke1fBuZaAHA2kzBZSJb482uclLe446qWc0+Jsfq05zS/4i991Brf/erL15X
	 FsUpwoVwlbyNo4C3UEyxGQFcTnXUA887AzRh7GBUHkNW/osBQCD2T4092uaGvkU7fe
	 VR6lBKFh7bGxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fuad Tabba <tabba@google.com>,
	Will Deacon <will@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>
Subject: Re: [PATCH 6.18.y] KVM: arm64: Bound used_lrs when flushing the pKVM hyp vCPU
Date: Thu, 16 Jul 2026 21:37:39 -0400
Message-ID: <20260716232340.0015-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716132434.239763-1-fuad.tabba@linux.dev>
References: <20260716132434.239763-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 16, 2026 at 02:24:34PM +0100, Fuad Tabba wrote:
> flush_hyp_vcpu() copies the host vGIC state into the hyp's private vCPU
> on every run. The vGIC list register save and restore use used_lrs as
> their loop bound and expect it to stay within the number of implemented
> list registers.

Queued for 6.18, thanks. I've also picked up your 6.12.y and 6.6.y
backports of this one and of the __hyp_running_vcpu fix.

-- 
Thanks,
Sasha
