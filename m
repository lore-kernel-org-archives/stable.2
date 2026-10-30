Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393658;
	b=OlSU2oKf1zwUs3soNQdtoyAtljFae4Z0uiSJpxoT2wgqKwvhpjzOzwBAOrAE5DIFMa+6
	 Z2hSwizcvvwMdm42GRGIb4HPCPI6uAuMT5094W67LrANJJ3yrC+7nGvCmgmCyBBpK2sh7
	 rkJraCui/qeMiMWOtuilXITBqZxI6iDi3b3MapYBSt36NkAzSv0uHD9jmqF7MSRDZltVj
	 YBsxjD8kCjh7Me6zwbkmDx+IGBThJ/f9o7/tq4Y6wrZ6CPqSAW4xqPUXdyW6bopPfghLS
	 ModKuUBB3SuxFfMcwUhMul5R9q0a2ITNARYy9/pGKUN0r/3U6gq+0TW9+bajznwY5LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393658;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xb/55TQzsueVMcDAVPu8BhBmeRS3YlB+eES9wFQHZ8U=;
	b=sMpb9n4bAwp/69Loz3+aY6IlSN+9LlNXKf/OO3hQLTjqFYvK9tJq85fHcQj2fLeEPPLG
	 KmBdVMChFJETKNOMngOUBUPpwDrmTIQ/+12xXXi8KMeBz77zkjQIGwHG7Qf+n44htjarU
	 ABPIFv8vFKWGQDsGnPbi6UibPU+EXseFJE/5iT+mv/D2CbDxsCQAdLrh2M8TkbK9grVho
	 zMZopXPuav/psNUZWZcHFi4kOJ/lFV7AYjBbIiW0F3Rtj5rDUWvOYST16VNANTpzEMmta
	 AiIUXPpXzuYH9Sc4nXQjh0mcFXydQAPcrr4Xxm5YQvdJV4kMyn6MXsXX5Hh5yC4X7pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TarLfKNd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF13A606A324;
	Fri, 30 Oct 2026 20:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TarLfKNd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFEE1F00A17;
	Fri, 30 Oct 2026 20:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393657;
	bh=Xb/55TQzsueVMcDAVPu8BhBmeRS3YlB+eES9wFQHZ8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TarLfKNdbcExiIBgFMF+ptkARk7NGrs75HlA45F8ISgJHYoGU/34fGz8m1tpV0498
	 RmTrFApNgAq0zSvGCwgN0htlCAHUsh6l3M/67rT3uYFcHrQunQWhfjA4D8g4Oars3X
	 Q5J5Y/MNBDWsCyJhr7d4Jio2lyS0W0ODD4/R08XwcqCNfoZIbAeD4yeTWlO2jR0IMZ
	 7CtLIXzEgEBYH+Fync6y0oz5LfvN7MPqZ+tQfjnrCys4jaYPhjL5VOdBi32xx3uXtw
	 p8MbMYYZWlYGzW7rHjWwHWFmcerIP2bR19xKQsbi25vwX9uwOTiUE8h2cwPScyBcOv
	 bLktUgyckDsOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: Re: [PATCH 6.6.y 6.1.y] kbuild: link-vmlinux.sh: improve detection of third pass requirement
Date: Fri, 30 Oct 2026 16:54:07 -0400
Message-ID: <2026-10-30-1-daily-reply-0004-kbuild-kallsyms-third-pass-6-6-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030-linux-kallsyms-fix-6-6-v1-1-91a57d3197cd@linaro.org>
References: <20261030-linux-kallsyms-fix-6-6-v1-1-91a57d3197cd@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Update link-vmlinux.sh to not rely on file size of
> .tmp_vmlinux?.kallsyms.o alone but to also consider symbol offsets
> within to resolve this, and do a third pass if required.

Queued for 6.6 and 6.1, thanks.

-- 
Thanks,
Sasha
