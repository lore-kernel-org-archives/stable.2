Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634642;
	b=pc26BFCMeY2QAhZGMgDTcvEc0R/2S6cpT7x4WBjsujLW9yu78hmZ/8J9DBIXK+XzZdN/
	 QJ6i+KcfZekNJYE6LmxfdN6qAdWeu/cZiAtaTyT2voatSKFwyb5E92mLpnWwyDvrZJ3NY
	 DoMr3KMpKWDABSSmUz7P+j2y0uJMre0tGRxEuwFeimbzUAp76XlXlFO1lXfsbfaq+AKuR
	 B+q/2zNgPbizNusjjK3C1VGFYOfR0OVVqdTzvlnfUtM2Cg/iYPoma//avU5Uknh5sl517
	 o5ctUpd7+joOTtZ3yMYFZg+mnNunDC6hIuUdZMwPbw1bHHEheLSixAlVkxwqgFovLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/dZrxIbh6RTSU4Bjb81Y9TDCjOr0VKfEVlrnhiqKUd4=;
	b=e7L2s9oXd2xlcy5pDhGU3rMEShAfRi3GedvBARHRP/DqbjXf9sPRwiTr7jYwfOA1bKhe
	 Oa78q7sYenM/LkVi9QC7c2jcwAov5/g9lW6vyFbRWH3+Lvyiilc7AaCFQFwXfQsUPi/Kb
	 YEljilO46NpDEX0GYss46LZ2kzDteRUZdY9jn2FN2R+4eNarHT+aT3p1x1NAxPjqlwvgd
	 nLDzHe1JT4lQXkd65flKB+M0DO0VjL5C2D/dJmgfAciTOfluvApodsFymWyZwdtGZVQhX
	 LVsc6ZgViEeiilV1muvz6tPLKfnrBd0MqLfE19lu3HG6g00Az+0TsxcfuprIDdM0Vqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCaXCxSB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C801606A319;
	Thu, 22 Oct 2026 02:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCaXCxSB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4C71F000C1;
	Thu, 22 Oct 2026 02:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634642;
	bh=/dZrxIbh6RTSU4Bjb81Y9TDCjOr0VKfEVlrnhiqKUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCaXCxSB7dbVifOnVq9LNkGNcuToeD9pkMlyYHvcSgBqYZbbEYyKtPP5yaMMxYhpe
	 xnliqHiuTvP+za3qjEP/ysbvHJeoOGQpAxOesj0123Mk1ZDbYOYl/OchrYABVKLWDS
	 69oNhNzjdwp+1ZMwnjF3+gu16C+hyq8+Z3E60IYreHV7ZzhGRvC84hPvpsNY/j9Kdc
	 dcQTSYqcGh/rko6aBRV4CxhLyWmSMd/Fg0W3Ny9j8H2TBafmDLsUGdeNb8044rIo5l
	 OlO5Z9nRQtAl6/2/CXu9aWD/sF+KYg0EW7jFOHYOlELgdovho45NLzQaTSGecNzWiO
	 wkZwUQEYOPT9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Kevin Cheng <chengkev@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Laight <david.laight.linux@gmail.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Luiz Capitulino <luizcap@redhat.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Rik van Riel <riel@surriel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Tal Zussman <tz2294@columbia.edu>,
	andrew.cooper3@citrix.com,
	gregkh@linuxfoundation.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nikola Ciprich <nikola.ciprich@linuxbox.cz>,
	Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH 6.18.y] KVM: SVM: Stop toggling virtual VMSAVE/VMLOAD on intercept recalc
Date: Wed, 21 Oct 2026 22:03:29 -0400
Message-ID: <2026-10-21-1-daily-reply-0004-kvm-svm-vmsave-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019214611.404880-1-yosry@kernel.org>
References: <20261019214611.404880-1-yosry@kernel.org>
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

> Virtual VMSAVE/VMLOAD enablement (i.e.
> VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK) is set/cleared by
> svm_recalc_instruction_intercepts() when the intercepts are cleared/set.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
