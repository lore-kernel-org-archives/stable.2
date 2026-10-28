Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219859;
	b=Jnx73JeU+ee/P1TB1GTNzV1Z+/AIqw95WeYjKmWYNV2slqkVU7RZaMIEHcXGYi/xifHX
	 v6ieIdk1K6//9cT8S+8m5f8DdbdrTltXX7fJWxNCvGk98cnuUcy5ZEd9E6xu9GoaOIvS0
	 BmIu8D8n7MVyfvdLlwk7+bzoVz0c1YP7Hz8/Ib7/uE5CLnfO+r+Qnafy2ic4F1GFNc8hb
	 c1Fj5vb8dSsDVDwirUd2uFmRbzYzvUgIBJXczmiLWLskBJsOjCiELuT8yYd+XwxWzIQCF
	 hSDK3GPTKNcPqaiaDpOf8tJdHG1z7qDXPOhBCgfTMcBxq/4WeLzkogWVBO3QTjNZGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219859;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=oj1lyO8CIX4oSXtDos3MWpr0D3srxGl+35ySEqyQsvE=;
	b=eMxMxPEwCi4Up/fVuS58jTu0RMSLyy/aL1TEbx/MKwRTZSRJPNa9bahqd1dFbwDFxbl0
	 TupYz/o5Dmr2Zt77LoT+6A3PMHswfccLZ7vucSh9CEExUVF+BEzOl6UWhQikK0CqaUSaK
	 azpSGVyVvVV6XDnrYJSWaWKdutd/addXQVzV/JZ9p0Bl/+NqnYSvMs6Ogtpc0yJrBSiKw
	 rC1DZAw7VcX57VtGyQtnrf8Hr+x9B4JwVNWYJp52JtXXzZFjfTvvhkBoT2rBi1fAbTSIE
	 QWVhxbI3Mndl2OB1roJxRro/aKKXW5eycFR2k1ZcN87xhBYQ/EIXy0tzthg+ZoEtLZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncu9Dfir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BA606A31A;
	Wed, 28 Oct 2026 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ncu9Dfir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3BD1F01825;
	Wed, 28 Oct 2026 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793219858;
	bh=oj1lyO8CIX4oSXtDos3MWpr0D3srxGl+35ySEqyQsvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ncu9DfiraLPRvKYf9kIaxfvp9YfD75C18sih8ao/6wCR9R9vSlJTBFBm9GdvKGokr
	 m/aayADpprvj20FDNqr5t8oeXaEFiwRgwug9HCS5lSBNB3Txi2XYK2ZRw0eFg+YbZI
	 0LqcD1hd4crcaN/sD6MfHbAYNef4emqvR9G2c5ClaXbyl5vwKMllJll/Iazr3Sb1dP
	 QEy9qMqyWl1TLeLfi1Q1+Wln7fdiH+YluiW66Nragd6QEu7WfhBciIBgWro9tyI5aM
	 kHQmXhXZOHLEIkZIOqUz3clJqx5v6ccce5a71r1rcHPaJLK37oYnLmGSlZFSwUwleP
	 UiHbVtxm7v04w==
Message-ID: <ce84acad-fbc9-430c-9be4-c9e86e615fef@kernel.org>
Date: Wed, 28 Oct 2026 21:37:27 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] mm/shmem: honour F_SEAL_EXEC when an ACL is set
To: Balbir Singh <balbirs@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "Pratyush Yadav (Google)" <pratyush@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-4-4ce3baf2db4b@kernel.org> <auHJOSkggc-V9dVi@parvat>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <auHJOSkggc-V9dVi@parvat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 11:06, Balbir Singh wrote:
> On Wed, Oct 28, 2026 at 10:55:02AM +0100, David Hildenbrand (Arm) wrote:
>> From: Chris Mason <mason@kernel.org>
>>
>> The owner of a memfd sealed with F_SEAL_EXEC can still change its
>> execute bits by setting a POSIX access ACL. With CONFIG_TMPFS_POSIX_ACL,
>> this lets an unprivileged owner make a non-executable memfd executable,
>> bypassing vm.memfd_noexec=2.
>>
>> simple_set_acl() updates i_mode directly, bypassing the seal check in
>> shmem_setattr(). Add shmem_set_acl() to check the resulting mode. Share
>> the F_SEAL_EXEC check with shmem_setattr() using memfd_check_seals_mode()
>> in include/linux/memfd.h.
>>
>> Fix generated by an LLM and sent by Chris Mason in private.
>>
>> Fixes: 6fd7353829ca ("mm/memfd: add F_SEAL_EXEC")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> Acked-by: Pedro Falcato <pfalcato@suse.de>
>> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>> Acked-by: Zi Yan <ziy@nvidia.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>> [ david: use common helper; simplify description ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  include/linux/memfd.h |  9 +++++++++
>>  mm/shmem.c            | 35 ++++++++++++++++++++++++++++++-----
>>  2 files changed, 39 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/memfd.h b/include/linux/memfd.h
>> index c159e40e3f34..272479317cf1 100644
>> --- a/include/linux/memfd.h
>> +++ b/include/linux/memfd.h
>> @@ -2,10 +2,19 @@
>>  #ifndef __LINUX_MEMFD_H
>>  #define __LINUX_MEMFD_H
>>  
>> +#include <linux/fcntl.h>
>>  #include <linux/file.h>
>>  
>>  #define MEMFD_ANON_NAME "[memfd]"
>>  
>> +static inline int memfd_check_seals_mode(unsigned int seals, umode_t old_mode,
>> +		umode_t new_mode)
>> +{
>> +	if ((seals & F_SEAL_EXEC) && ((old_mode ^ new_mode) & 0111))
>> +		return -EPERM;
>> +	return 0;
>> +}
>> +
>>  #ifdef CONFIG_MEMFD_CREATE
>>  extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
>>  struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx);
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index af21a89abb0f..e3e4bbbe1d80 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -77,6 +77,7 @@ static struct vfsmount *shm_mnt __ro_after_init;
>>  #include <linux/magic.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/fcntl.h>
>> +#include <linux/memfd.h>
>>  #include <uapi/linux/memfd.h>
>>  #include <linux/rmap.h>
>>  #include <linux/uuid.h>
>> @@ -1546,10 +1547,11 @@ static int shmem_setattr(const struct mnt_idmap *idmap,
>>  	if (error)
>>  		return error;
>>  
>> -	if ((info->seals & F_SEAL_EXEC) && (attr->ia_valid & ATTR_MODE)) {
>> -		if ((inode->i_mode ^ attr->ia_mode) & 0111) {
>> -			return -EPERM;
>> -		}
>> +	if (attr->ia_valid & ATTR_MODE) {
>> +		error = memfd_check_seals_mode(info->seals, inode->i_mode,
>> +					       attr->ia_mode);
>> +		if (error)
>> +			return error;
>>  	}
>>  
>>  	if (S_ISREG(inode->i_mode) && (attr->ia_valid & ATTR_SIZE)) {
>> @@ -5404,12 +5406,35 @@ static const struct file_operations shmem_file_operations = {
>>  #endif
>>  };
>>  
>> +#ifdef CONFIG_TMPFS_POSIX_ACL
>> +static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
>> +		struct posix_acl *acl, int type)
>> +{
>> +	struct inode *inode = d_inode(dentry);
>> +	umode_t mode = inode->i_mode;
>> +	int error;
>> +
>> +	if (type == ACL_TYPE_ACCESS) {
>> +		error = posix_acl_equiv_mode(acl, &mode);
>> +		if (error < 0)
>> +			return error;
>> +		error = memfd_check_seals_mode(SHMEM_I(inode)->seals,
>> +					       inode->i_mode, mode);
>> +		if (error)
>> +			return error;
>> +	}
>> +	return simple_set_acl(idmap, dentry, acl, type);
>> +}
>> +#else
>> +#define shmem_set_acl NULL
>> +#endif
>> +
>>  static const struct inode_operations shmem_inode_operations = {
>>  	.getattr	= shmem_getattr,
>>  	.setattr	= shmem_setattr,
>>  #ifdef CONFIG_TMPFS_XATTR
>>  	.listxattr	= shmem_listxattr,
>> -	.set_acl	= simple_set_acl,
>> +	.set_acl	= shmem_set_acl,
> 
> If CONFIG_TMPFS_POSIX_ACL is not defined, do we want to set the set_acl
> callback to NULL? Earlier it was simple_set_acl

Excellent question: because simple_set_acl is NULL for !CONFIG_FS_POSIX_ACL.
It's clearer to jsut keep using shmem_set_acl here, thanks!

-- 
Cheers,

David
