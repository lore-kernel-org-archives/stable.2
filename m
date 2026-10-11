Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C893515CD;
	Sun, 11 Oct 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737334; cv=none; b=LINMPGPJLt+fZmGWSRDwC6IgobYiPdLj61ta+PkB/wV9gFQqmn8GgeDz0jYGL4fpHp+WL0aQAxSqUhg8hCqJoMvR8CbhQLBlzgki3J2MQ/BDOjgVMuUBqSR337hXFWpmbdhkl9Std/Y8NQWR+0o4NMpW/T2n0dj3DrgYdUJjJE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737334; c=relaxed/simple;
	bh=74+FXS+xGUn7KUsYy9Ic+iRixh66lp4CbO7XbN8Kj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTBhnfxGZQa4dbKE8f35TAPmf2BB8EJf2ryw71348VDM38spkeieiA8/cqNaRXtWOJogw32RciMP1w3odZ10+BjeB6zmOsI1cs81gZr/uBP+craJlNVqnHWg4yyaNbYD6cDG21COjkMX+WpEm4+3dHUlpjQ0gKc8imMbSNhNBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKgN+wf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKgN+wf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 295871F0089B;
	Sun, 11 Oct 2026 16:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737332;
	bh=H0u6EQnNu8ZfGrfLxF7kpe/UkjrHr2fM9ZHBe+cSDqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AKgN+wf/1+t8bRlSmDN/qjgiQh8s8atcHVzIWqVaEQTtI6eFmeqfTPn3vU1wXAOp1
	 ZO5z3D1WoKzSGmtSty4fFd+gRtpSKP9f+MmosyUYlxYYsiQ/eYdcaOMq3vUccZFH7h
	 prJS8BLI6V0hbb60Apf8KDMeC+cDRFFtco0MUtgi2EeslHiLq8OMvJIfIO7AvrK71t
	 e6iKwGMZ9dKw8JMuIIz8d2U0bFpMlj/9H83sg125rDlk/lUBMBWY9Ra7GInYlNNOAG
	 GpfKk6gbtf8Kwi/TTLrjrhf6sTfAVqp2QIDQy+4ue5kgYAOZyOY53HN0Va04JEkQcg
	 1i5avINf4MQAg==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david@readahead.eu>,
	Hans de Goede <hdegoede@redhat.com>,
	Douglas Anderson <dianders@chromium.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Kenny Levinsen <kl@kl.wtf>,
	Ai Chao <aichao@kylinos.cn>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v6.6-v6.1 1/2] HID: core: introduce hid_safe_input_report()
Date: Sun, 11 Oct 2026 12:48:25 -0400
Message-ID: <2026-10-11-1-daily-reply-0018-hid-safe-input-report-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011103900.2201441-1-lee@kernel.org>
References: <20261011103900.2201441-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hid_input_report() is used in too many places to have a commit that
> doesn't cross subsystem borders. Instead of changing the API, introduce
> a new one when things matters in the transport layers:

Queued the series for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
