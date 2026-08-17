Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E100435EC8;
	Mon, 17 Aug 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980288; cv=none; b=AfW1YB5NZ+laYnlZ7YKjPi9UEAcb/5v2lPaXNBb4BUtQIn+3AGEGf/g4JGb5w7G5NfC1hdcNG3eywu+rwDtQKEFV16cYG5NLSmwDvpEbBGocOmKdltiomz0gegGeUblTdPvafpUSqAIdaUQgCqDIlyVdJeqTWzK+7K5er6Cu9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980288; c=relaxed/simple;
	bh=dNcimHv0Z3LaZAFyeWiXLwH88Bh+R3lMKtSTFiy3j3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ge15cUYBOlZnf7m5bP1EZY15EtRepfo9CIPivUUFeM8TZvbbIvVRzZ+oqO6Qz0hMhfKPJnpiyvddskbHeZ7Hpy92SXXuUPrbrOHoTc2sJpBDW5M7DJztVaKcvrKVQhqF2VPU3MTM+ItsInYE77D9Cp/mx49srObNnBp/6n6bvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5MqzcPF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5MqzcPF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E1F1F00A3A;
	Mon, 17 Aug 2026 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786980287;
	bh=5AyCoTGV33G1LxEHnCfLrKk+yhp8RcBBAwKqrk6jpAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5MqzcPF01fkTW0OBZiS5eiLv1sSRTqrlO/MkHSvZ+knG8JGTGDLCvjJGGpcUEOqg
	 DxJHU/5aomKCM1oe5q6HFPlMSV++0URmw/8c+0aNsq2Z8Kf0JbQat0P2YTFpvEpjIm
	 +Ej51auh42chu3yPBEXZUF362LqC56WnW4WarG5a2JuD+cSna4qAoBCuV7bpdrIHAL
	 xZCrl9dnHhfhUu8mSmhRY5Bq3RdVl9P2HQCuGxA/+TXtDEwl7LXXcUt4kROVH13Lk5
	 kKQlX39Chb5xNv4DwOyAJtAeAMHOK2FOUyasyCeVVINlgbAIn0V6T40ce9ieie0DGH
	 7ca4IcZKCIiMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	Michael Diesen <michael.diesen@posteo.de>
Subject: Re: Please apply bed0c8084044 to 7.1.y and 6.18.y
Date: Mon, 17 Aug 2026 11:24:39 -0400
Message-ID: <20260817150000.1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <1786957127.718071.28963@posteo.de>
References: <1786957127.718071.28963@posteo.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Could you queue bed0c8084044 ("ALSA: hda/realtek: Add quirk for HP
> Dragonfly Folio G3 2-in-1 (103c:8a05)") for 6.18.y as well?

Queued for 6.18, thanks - sorry for the miss, the prerequisite went in
ahead of it and this one never followed.

-- 
Thanks,
Sasha
