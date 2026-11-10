Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794324245;
	b=itdrE2w62YxxVpbQB6cYjGaginC7Qw9ulEoYyYmABOs7r5zt/bYSrRbx8uk6cgN8uN2m
	 4Q38QHMMgTdevaERCVeNbQEC150AIsmstA06iv67lSUrZV09OUWwnaO/PazYhk15wHGsr
	 /wFzbKT5p9L/qx8K8KoFce8uiSSWpLKpAQ0oIbfCnj4o9EhsgVW06dE/W+9Z9H2P86xRU
	 x038Uog8svLiBrf1253m3yzevnJ4W0eZj+uGl1+XMi4LTVixgu63xohktynmHhvQ+y/Hl
	 jtMKHVVfrGNdU1a0mEPE3+EsGmEAhfOEdK42JxJx7K5GvmKQQ7P/x2yG1KQD4TuHyCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794324245;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Brxv2z6idZtREPfRr5/fTTwxmSaAOm4uPB5j2ywZ+D4=;
	b=nvSEbThWhLTsHaAu3lDMlMA7gsl/PxT+GWZHlpYS30dgRSRDo3H71qm8f7X2NFfMlQhs
	 DQ7yfrh4McSCNxMheDfUY3MroHd+nTe2y2C5pavxJdwU1cxUw7e8QMaCbENnRi6NMjvQ5
	 TgRQR+6gZ6DCtkj/+eCq10YcED77iPJFQQe7GxoQoQCErUSZjEbtRfAJp78zSX46FCllm
	 Pkbbh337/soNp3cdUegKCy/zh6Uk3TcrrEkok4CAEhVVc/2ILueIDQlGoMB0byXMG47qh
	 q6qiDTWEQRlubSl5AWszOpxlLKxTTEWZ4+blQjoI9MWb6aXM02N64LzvTPtQykHM1UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKtfaFSZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CBE606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKtfaFSZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32F21F0089F;
	Tue, 10 Nov 2026 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794324244;
	bh=Brxv2z6idZtREPfRr5/fTTwxmSaAOm4uPB5j2ywZ+D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKtfaFSZPrwPPwMLwKvIlJ8PeRPvrgIapPEPeKTRsXM1AR2VGPHTxsK/l7KQ1xaSr
	 xthYqUJAu2qXxj+GU18dX5K5rqNAS2s8LGfXhycmVwYY3ArRbxBtt4oMIcD0stvJaK
	 AEdW5S8Q9PYq234tX0dBPT6Cb+qJi+j/PqRGGV2bJK0TpY/6xNSW2uD8hIdvXzTbm6
	 JbWCm2AF4ZLXik+sDmcwUIWjUQNj1V1yrxkic/Rp82bxBEwneKTbhgdGgkQxyXDxiH
	 OnodmMS0SOPUPsAHjHtYtMUpiVcRdSk84Z/2K8F3avO3UVlg+GFPfyd0MTNzxDrJPZ
	 S16zcZ6gKU8/w==
From: Sasha Levin <sashal@kernel.org>
To: Lin Wang <wanglin@open-hieco.net>
Cc: Sasha Levin <sashal@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	stable@vger.kernel.org,
	Wanglinwl <wanglinwl@hygon.cn>
Subject: Re: FAILED: patch "[PATCH] hwmon: (k10temp) Stop matching Hygon devices" failed to apply to 6.6-stable tree
Date: Tue, 10 Nov 2026 10:24:00 -0500
Message-ID: <20261110152402.2141028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <13c1ffd8-4483-4a6e-8781-25143e12e6ea@open-hieco.net>
References: <20261107053014-failed-6.6-08e6615c909b@kernel.org> <c86128b4-1ead-4645-aaca-4f2584faba62@open-hieco.net> <13c1ffd8-4483-4a6e-8781-25143e12e6ea@open-hieco.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 10, 2026 at 11:12:09AM +0800, Lin Wang wrote:
> Please exclude this commit from 7.3.y as well, or revert it if it is
> already included.

Dropped 08e6615c909b from the 7.3, 6.18 and 6.12 queues, thanks.

-- 
Thanks,
Sasha
