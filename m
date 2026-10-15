Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABD4A2E27;
	Thu, 15 Oct 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076792; cv=none; b=rHdg0T8s2Htel5qc2JFYJmlVMoC0No7CJJe3AAyfXg6/jaN8/c1Xh+oUTn8hW6AhsUflicpfOn505OV5U9Qx+DsFhu4fDse+LOaY3T8+qPg1/jLToMDABbHbpAoSAL5qIuG/PoUJCSV++ZzZ9otHDhMhzmPD5FLbaIbeKEtVnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076792; c=relaxed/simple;
	bh=44ObRLLeSJEZjlONSmEVnsFZ1XHrhH0KyZ3LV7lCCZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DTcu1Us03DxyDYK+UgkQoDXq0/49Z/i5by/hulwa1NLm8iIAiEH4objmtBVoOOm2h18btPmiopqEupArA4NtrbZtaWc7XM4zeH6AjcYX59AS028mRtQjkckoY3dfntbZ5syr5JLnGaxqV8p+xHtyvhluFZlDdn8BJW/TlJIPZKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMQD5ome; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMQD5ome"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE6A1F000C4;
	Thu, 15 Oct 2026 15:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792076791;
	bh=Bt2xHiRLuCEUEUjwNFd1YMNrjnY78GVVrs/wdHe6UPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RMQD5omeVYZmDTStIvB+SQji/k4XirLOZuImSrmf7poXZIAji5j3jcLMb+ls0XIZu
	 mW9Sl9BO08iYzHQCz6eUDueLEFjM8WcEMVGll9xqHJU1G0E8fts5BTuuEzeS8HjXOe
	 hxfqc4bTVgyDPP6wStoHBicP3YLAwyW9/ST1KH/DrVmGVpiRwnjWb396Vc+dI8S975
	 U0kZkuWlSkzooteUDh+xLkAgJ5T8rgINhnTJolN6N80v7I0WNc9oxTwgt73pDUE9MB
	 3oLqjquRuvtgdHt+vQVZ7pIzJ6l4p+B82BZ5sJv81Wl8bxWdbJCgFnffnPLNnZKSEQ
	 ejLN4AV6KWNQQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Alexey Charkov <alchark@flipper.net>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261001-bq25792-volatile-v1-1-cb3d4ec8a414@flipper.net>
References: <20261001-bq25792-volatile-v1-1-cb3d4ec8a414@flipper.net>
Subject: Re: (subset) [PATCH] mfd: bq257xx: Mark self-modifying BQ25792
 registers volatile
Message-Id: <179207679007.2041061.16299423448287914984.b4-ty@b4>
Date: Thu, 15 Oct 2026 16:06:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 01 Oct 2026 17:30:23 +0400, Alexey Charkov wrote:
> Some BQ25792 configuration registers change without being written: input
> source detection sets VINDPM and IINDPM at plug-in, plug-in also clears
> EN_HIZ, the FORCE_* bits clear once their operation starts or completes,
> EN_ACDRV1/2 follow input path changes, and ADC_EN clears after a one-shot
> conversion. Reading them from the cache returns stale values.
> 
> Mark these registers volatile, keeping the cache for the rest.
> 
> [...]

Applied, thanks!

[1/1] mfd: bq257xx: Mark self-modifying BQ25792 registers volatile
      commit: 56d974f3ad074a60bf877d131eab8b1df5b4f069

--
Lee Jones [李琼斯]

