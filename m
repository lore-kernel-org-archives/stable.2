Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976A63A875E;
	Fri, 26 Jun 2026 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496491; cv=none; b=dKfjWC/xSUXEZBvVNO8vNwXhQt4wWJlqs0FScYnQ92KkyySr4fdvF8pby1nI+bFIKtvNcwqMZBkqxT7SQvTj9q0D7Z7/3DVWVozDp+NzesrchBhDFMW4ccqoHcPS2s3M7rQgt+zE9IPvOGpTXeuXUcYudwCgyZ7XM376Y/Rzf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496491; c=relaxed/simple;
	bh=dIdnGL6IvbkcbDiXHYQqD/Ev/2LQPtDuUZ7rfkWmnM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBc6ISN5Rw2ZmyIeU/77gLXJab3vwyCrzQ+M6sJPy33Cf95VKvm3dslFcX9VnX9pM74/gGnjmfL09u4jt57rVapNtAuM1EpaSwfz/GuokLGCgNi1ptDKA4qBXJ5lToRsWFSy3LuAbqHcsVbCimQy5FQyjmZ4Qy+zFjAufBzc0T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKMuQPYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKMuQPYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859431F00A3F;
	Fri, 26 Jun 2026 17:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496490;
	bh=9UZVX0Z6Eb9Ku3XBO729YO5s0eNrnrNTp3rE7j4neMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKMuQPYlO4FrmwrJS7Fe+7JSgIgyzAbSIZ3cyUeFJAkRP9DN6TsOTR785YDRMr9Zz
	 inuUqivywKHnt6/DsitTIMd0ShSfVOtVlaEgBfdupLXkEmVg10qD4eTmLrAVyc5s7y
	 /gYtuNSmn/qHRVRb1GuJKfChMOipIFQHqhg8fiPDo/RMsixlMAZIRY1ZCKniZhAb1v
	 bWN1LagBqtlOgPZY7Z6873fYcB0NNRySkAfuoIdBol7WhUjhGowzOwuOSq4OMbSGi9
	 XeZt99qDG165oGdNroyJ5t5fSmJSR7oRYq3ozLk0ZIXG3izdq0tInKY/zXU/4XatZ4
	 XvwAtLGj83PJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:21 -0400
Message-ID: <stable-reply-item006-role-618-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112315.1777138-1-pbonzini@redhat.com>
References: <20260626112315.1777138-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
