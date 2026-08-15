Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4023D7C2;
	Sat, 15 Aug 2026 02:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761230; cv=none; b=XDrFfcptru84a650xhzbPB8Z8/8ZkHYo+JPPIjmNk1vy+IAKCdosbpIdSVvkTV0Nern/yoweMoyF1JYKX+2B//ZovToMG0svRWq7YGhfYmDMksF8K70MNbGKcVMuZqKfb4SOlf0C3+xbJ6Sd3qbQjmsz+bwjp3XMHbfDSgSOZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761230; c=relaxed/simple;
	bh=FjLWJiJ2ktzDYa4j6UcmQz/1w6b4Xwl/mQwSvP4Sj8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oh9NqzsD1ycv78E5WPcdvk13vEAcd5Ygvm9HtoPqtvCSANFb4VKphzK9puYRSACGrOC20Gr70XqI6FSOglb8mt4vkfrKd2M+vjrA74hWVmmsZNwYW4yi6u92i7p7E4Dkx7F0o7xd5FD7s9B+7dHp85z9j7juLdidOMtVrEYFIxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCogrhHA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCogrhHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9996C1F00A3E;
	Sat, 15 Aug 2026 02:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761229;
	bh=WZK+K+bCa7NZn2eJGUhA3eHDJyFYVSwRrE30vSY/0Qs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCogrhHA6UM9ESNqhVVouhiASpZJmD2CKrx/y+ZCKNPa1Vfxgk6GAN+Iw20Y2kqo3
	 Zvoht79Zkh4t1Aec3beeznlMBBKaYD72nM7VtZBcN4CiLMVcVCnvOUMFHN21JTzenV
	 NebRGAtdCmm3ZWT18+4nc/1IFYaG0spjTKf0lM++PPG2y2PjZrhN/H1DWJs8wCiuhm
	 i727ywAPvKB2IzCLJAsJ5UA6kUMxumlQnfLQ6USqi3xUakWbwcnjwWXAI0fOCPusNo
	 jjDiE1lfVAy8v66qlGBJ2AecfQpJWJUsfwzQCmdwhHtTN75Cx0EeJ36SuiWDmbZ9Lo
	 tYwbCiqCnX2mQ==
From: Sasha Levin <sashal@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgKFNVU0Up?= <ricardo@marliere.net>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH 7.1.y 0/4] selftests: Fixes for BPF
Date: Fri, 14 Aug 2026 22:33:20 -0400
Message-ID: <20260814193000.20@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
References: <20260813-7-1-y-selftests-bpf-udp_xsk-v1-0-cd5c51e7dcec@marliere.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please consider merging the following patches, found through openSUSE CI.
>
> [1/4] and [2/4] are for test_xsk.sh:

Queued 1/4 and 2/4 for 7.1, thanks. I moved 2/4's [ rbm: ] note above the
Signed-off-by block so git parses the trailers again; the diff is untouched.

3/4 and 4/4 need a v2 - the [ Upstream commit ] SHA in each of them is not a
commit in any tree. I've replied on both patches with the correct ones.

-- 
Thanks,
Sasha
