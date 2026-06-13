Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F340727FD51;
	Sat, 13 Jun 2026 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362301; cv=none; b=QrJDDbHbprPGl3fTTVYuiPN9kkiVwoTFORunVCNCEkJaNxHEZL43JznHCs2GNdo2ydH5QotssIPsgIrrezJYVBTvu27hd/F1pp1gW+I1+Yarvhxdor7g8jIgHxQcozLUYlHvg45maDnlLRe/mOletiruMyQVgzF0vCNERnOXYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362301; c=relaxed/simple;
	bh=l6ajO6PEYiRPvMXI+CPCWfcvCib+DRUZjHwnIx117VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyY0NnTpFGLVy7dGHaaJu4KgKKBheAOIzMMFpJbg9DFj0zo7yvX1zlBJ3nnZSakYt+cknDL9B68g3Z+R0dG3YTx6LYwyHqDCyu5UUNtzKKOWXzSr8WCqiaroLO0ijFDNXWYiIL9PM7xJi/F0K7zvQMqCVYLl1SX8hagJk7nWHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATEp7Nyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATEp7Nyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C071F000E9;
	Sat, 13 Jun 2026 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362297;
	bh=l6ajO6PEYiRPvMXI+CPCWfcvCib+DRUZjHwnIx117VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATEp7Nyg1KWkylf5Q4x2aSeRSrLRCwMg25N3l+DafS4pzdHGeTkEfGBIWBV3P2CdI
	 hr3SYx8cftxxcqANFuFSy3vEaaWT+8dYMQRL3a/hIKxyixLDrLbNkUweFDIBofXGgr
	 aooQS7SmBTBQne6TIGykTatvSZYbqr7584u85N4HjpMbnLx8EhiyQ1I2ZYz6ARxV3i
	 95Nfun10Qj/0DWeOA39SOLSCpYAEBNzrciA4ZMt8N4YxtihNhQSu5GNN3Ut35oBZcV
	 4CrZHueRHeKORy4qBzOJDc01a4y6xVnP6V112iRbRDkF5MF72pSJPaD/uvsSaeGpmp
	 LgxZkcgffV1Vw==
From: Sasha Levin <sashal@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	jonmkohler@gmail.com,
	Dongli Zhang <dongli.zhang@oracle.com>,
	Chao Gao <chao.gao@intel.com>,
	stable@vger.kernel.org,
	Gulshan Gabel <gulshan.gabel@nutanix.com>,
	Jon Kohler <jon@nutanix.com>
Subject: Re: [PATCH 6.18.y] KVM: VMX: Update SVI during runtime APICv activation
Date: Sat, 13 Jun 2026 10:51:26 -0400
Message-ID: <20260613143000.0001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612211003.2503400-1-jon@nutanix.com>
References: <20260612211003.2503400-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jun 12, 2026 at 02:10:01PM -0700, Jon Kohler wrote:
> From: Dongli Zhang <dongli.zhang@oracle.com>
>
> commit b2849bec936be642b5420801f902337f2507648e upstream.

Queued for 6.18.y, thanks. (And thanks Sean for the ack.)

--
Thanks,
Sasha
