Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792578399;
	b=D6rirFXir8ESnoVs3m9V+EPNMd67y69OwKV9eYj3iLwBA1DusD1jzM5UUIYHMx5BhYEI
	 3qeR1PfoBfKuoFNtawqmPerheihyD+/quqC0+ZHznidlyFXUsVe8ENGjx6kn29j1Sgo98
	 AsvmkWq8cZUkrSf5vA5xiWz3VEzbjdF5l4Mq4yfMGZZC3Cwl2GwLte53M/FabWOqqHQO3
	 3v5vpacKOApgpp0ythGWRD0CvVD+kGS2I6f/Ugd2ds2JYnMTPZdshN7pQ7S6IPvclTOK3
	 CPtxMSQBZQftGXl/FNShT2nmhUAXyjpWNd9fhGI90vnSNIHV0d9jmux+nn2l9AkkPuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578399;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XaHS5CUayuZ4u9kYgWWlcU+lZAuboyv4HW7QhXr3ncE=;
	b=ivboHv2D5w5f+BxnxNe0Dk9lFA91Aw1tDNmY0ledVf67AHPy1bWWZTrntJ8yW8xGMRQ9
	 SgKR8+M9R+yWmZLKsfeQ5lnmww48pnGvwJuIsHGj4cHYjwyHwmhAnR5hsoEFqWt9vGobr
	 5lgJekgRIoE4W90VvvuwhfKjiyIH69LGrVPurKkdk/pKj4BLNwjZoBt0j7BXjmzt81H7Q
	 xb3sEzyXyEJBF/w0iquM9IawJdlpRGE10Ff2EbPb4YXsJZFb7LmmzksZnwVyEHTSxEsma
	 j4jnzAa1oqDZCQBNHynA7zjDHfeL606vTRPZUHEJcu/iE83hHEHU9CcVuouVQ8H0o1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGfrVpnG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EAA606A31D;
	Wed, 21 Oct 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TGfrVpnG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15FA1F000CC;
	Wed, 21 Oct 2026 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792578398;
	bh=XaHS5CUayuZ4u9kYgWWlcU+lZAuboyv4HW7QhXr3ncE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TGfrVpnGhhnz8+qNwr+F5pcYKC43Xf9ZcczIokuC0v1hPtmmCmJFr2xauE0qDt4pb
	 XbK4/KakoluZiI6SwivbuUoXLiUyxZeRMjGm3hzKUHhpGkiK47M8vkn6F2pNst+AJL
	 qRb1pXCujiW4DTLfmVmkaZseqovwIvkrK+iUzSWRMsPGkc8LNypyM7bWXBTTLOBES3
	 Hu67TgcejmpIKFhHjJYnpD3I47/XGJcEob6IFWSUozEvlvlb5cndKjVztaUrTUbSGC
	 2ZQcy7LeEu5ABVn81q7IkcFr0ZvtjkoIUvxfIO6VZQ+Wozc9hIDwbr4+BQ3IbYXdVy
	 o9bpETxFMIQaw==
From: Christian Brauner <brauner@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Nikolaos Karaolidis <nick@karaolidis.com>
Cc: Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao1@huawei.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261016102515.111285-1-nick@karaolidis.com>
References: <20261016102515.111285-1-nick@karaolidis.com>
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be
 dropped
Message-Id: <20261021-geburt-heimlaufen-junitag-f8fc6bf55c5d@brauner>
Date: Wed, 21 Oct 2026 12:26:32 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ENKdDygeOB3ZkTFNXhwRYoQgyxPbVZNMT5pmJM216mA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdmBw1M21TvtRbzs1upidOfpL03edin8js9WqvfemUi
 bfPyez71VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR8DeMDA3TTBJz1WdP/nPG
 3i4riePENdfJDDK77AVzjUyUn6zd0cjI8OjYpV2+LPrcLzY9Pf/sZ8GarxbbjCetkq2OT2epW1o
 swAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 16 Oct 2026 10:25:15 +0000, Nikolaos Karaolidis wrote:
> fs: rotate inodes whose page cache could not be dropped

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs: rotate inodes whose page cache could not be dropped
      https://git.kernel.org/vfs/vfs/c/efe3ca110fdb

